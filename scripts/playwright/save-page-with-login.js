import { chromium } from 'playwright';
import { mkdir, writeFile } from 'node:fs/promises';
import { createInterface } from 'node:readline/promises';
import { stdin as input, stdout as output } from 'node:process';
import path from 'node:path';

const url = process.argv[2];
const childFolder = process.argv[3];

if (!url) {
  throw new Error(
    'Usage: node save-page.js <URL> [child-folder]\n' +
    'Example: node save-page.js "https://example.com" website1',
  );
}

if (
  childFolder &&
  (
    childFolder === '.' ||
    childFolder === '..' ||
    childFolder.includes('/') ||
    childFolder.includes('\\')
  )
) {
  throw new Error('Child folder must be a single folder name');
}

const rootFolder = path.resolve('saved-pages');
const outputFolder = childFolder
  ? path.join(rootFolder, childFolder)
  : rootFolder;

// A dedicated profile that retains cookies and authentication.
const profileFolder = path.resolve('.playwright-profile');

await mkdir(outputFolder, { recursive: true });

const context = await chromium.launchPersistentContext(profileFolder, {
  channel: 'chrome',
  headless: false,
  viewport: {
    width: 1440,
    height: 1000,
  },
});

try {
  const pages = context.pages();
  const page = pages[0] ?? await context.newPage();

  await page.goto(url, {
    waitUntil: 'load',
    timeout: 60_000,
  });

  const readline = createInterface({ input, output });

  await readline.question(
    '\nLog in if necessary and navigate to the page you want to save.\n' +
    'Press Enter when the page is ready...',
  );

  readline.close();

  // Allow late rendering, animations, and requests to settle.
  await page.waitForTimeout(2_000);

  await writeFile(
    path.join(outputFolder, 'page.html'),
    await page.content(),
    'utf8',
  );

  await page.screenshot({
    path: path.join(outputFolder, 'page.png'),
    fullPage: true,
  });

  const cdp = await context.newCDPSession(page);
  const snapshot = await cdp.send('Page.captureSnapshot', {
    format: 'mhtml',
  });

  await writeFile(
    path.join(outputFolder, 'page.mhtml'),
    snapshot.data,
    'utf8',
  );

  console.log(`\nPage saved to: ${outputFolder}`);
} finally {
  // Authentication remains stored in .playwright-profile.
  await context.close();
}
