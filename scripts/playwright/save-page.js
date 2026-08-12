import { chromium } from 'playwright';
import { mkdir, writeFile } from 'node:fs/promises';
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
  (childFolder === '.' ||
    childFolder === '..' ||
    childFolder.includes('/') ||
    childFolder.includes('\\'))
) {
  throw new Error('Child folder must be a single folder name');
}

const rootFolder = path.resolve('saved-pages');
const outputFolder = childFolder
  ? path.join(rootFolder, childFolder)
  : rootFolder;

await mkdir(outputFolder, { recursive: true });

const browser = await chromium.launch({
  headless: true,
});

try {
  const page = await browser.newPage({
    viewport: {
      width: 1440,
      height: 1000,
    },
  });

  await page.goto(url, {
    waitUntil: 'networkidle',
    timeout: 60_000,
  });

  await writeFile(
    path.join(outputFolder, 'page.html'),
    await page.content(),
    'utf8',
  );

  await page.screenshot({
    path: path.join(outputFolder, 'page.png'),
    fullPage: true,
  });

  const cdp = await page.context().newCDPSession(page);
  const snapshot = await cdp.send('Page.captureSnapshot', {
    format: 'mhtml',
  });

  await writeFile(
    path.join(outputFolder, 'page.mhtml'),
    snapshot.data,
    'utf8',
  );

  console.log(`Page saved to: ${outputFolder}`);
} finally {
  await browser.close();
}
