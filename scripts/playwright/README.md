# Save Web Pages with Playwright

This project contains two Playwright scripts for saving complete web-page references:

- `save-page.js` saves a publicly accessible page without authentication.
- `save-page-with-login.js` opens a visible Chrome window and retains authentication in a dedicated browser profile.

Both scripts create the same three files:

| File | Purpose |
| --- | --- |
| `page.html` | The rendered HTML DOM, useful for inspecting page structure. |
| `page.png` | A full-page screenshot showing the visual layout. |
| `page.mhtml` | An offline snapshot containing the page and most external resources, including stylesheets, images, and fonts. |

Provide all three files to an AI coding agent for the most complete reference. They describe the rendered result, but they do not contain the website's original project source code, backend, build configuration, or API implementation.

## Requirements

- Node.js 18 or newer
- npm
- Google Chrome for `save-page-with-login.js`

## Installation

Place both scripts in the project directory, then install Playwright and Chromium:

```bash
npm install playwright
npx playwright install chromium
```

The scripts use ES modules. Add this property to `package.json`:

```json
{
  "type": "module"
}
```

Alternatively, rename the scripts to use the `.mjs` extension and use those filenames in the commands below.

## Command format

Both scripts accept the same arguments:

```bash
node <script-name> <URL> [child-folder]
```

- `URL` is required.
- `child-folder` is optional and must be a single folder name.
- The child-folder name cannot contain `/` or `\` path separators.

If no child folder is provided, files are written directly to `saved-pages`. If a child folder is provided, files are written to `saved-pages/<child-folder>`.

Existing `page.html`, `page.png`, and `page.mhtml` files in the selected output directory are overwritten.

## Saving a public page

Use `save-page.js` when the page does not require authentication.

### Save directly to `saved-pages`

```bash
node save-page.js "https://example.com"
```

Output:

```text
saved-pages/
├── page.html
├── page.mhtml
└── page.png
```

### Save to a child folder

```bash
node save-page.js "https://example.com" example-homepage
```

Output:

```text
saved-pages/
└── example-homepage/
    ├── page.html
    ├── page.mhtml
    └── page.png
```

The public-page script runs Chromium in headless mode, loads the URL, creates the three files, and exits automatically.

## Saving a page that requires authentication

Use `save-page-with-login.js` when access requires a login, two-factor authentication, or other manual interaction.

```bash
node save-page-with-login.js "https://example.com/account" account-page
```

The authenticated flow works as follows:

1. The script opens a visible Chrome window.
2. Log in normally if the website asks you to authenticate.
3. Complete two-factor authentication or other verification if necessary.
4. Navigate to the exact page and state you want to save.
5. Wait for the relevant content to appear.
6. Return to the terminal and press Enter.
7. The script creates the three files and closes its Chrome window.

The files from the example command are saved here:

```text
saved-pages/
└── account-page/
    ├── page.html
    ├── page.mhtml
    └── page.png
```

### Reusing the authenticated session

`save-page-with-login.js` uses `.playwright-profile` as a dedicated persistent Chrome profile. Cookies, local storage, and other session data remain there after the script exits.

On later runs, the website will usually recognize the saved session and will not require another login. You may need to authenticate again if the website expires or revokes the session.

The script does not use or modify your regular Chrome profile. Do not open another Chrome or Playwright process using `.playwright-profile` while the authenticated script is running because browsers do not allow concurrent use of the same profile directory.

To discard all saved login sessions, close the script and delete `.playwright-profile`. The next run will create a clean profile and require you to log in again.

## Recommended `.gitignore`

Add these entries to `.gitignore`:

```gitignore
.playwright-profile/
saved-pages/
```

Never commit, upload, or share `.playwright-profile`. It can contain active authentication data.

## Providing a saved page to an AI agent

For the clearest reference, provide:

1. `page.png` to show the complete visual appearance.
2. `page.html` to expose the rendered DOM structure.
3. `page.mhtml` to preserve styles and downloaded resources in a single file.

Also explain which parts of the page the agent should reproduce and which behavior is relevant. A saved page does not reveal how server-side logic or protected API operations are implemented.

Before sharing files captured from an authenticated page, inspect them for personal information, private records, CSRF tokens, embedded API data, or other sensitive content.

## Limitations

- MHTML capture uses the Chromium DevTools Protocol and therefore requires Chromium or Chrome.
- Authentication, API calls, forms, and server-dependent interactions may not work in the offline MHTML copy.
- Content loaded only after scrolling or interacting may be absent unless it is visible before capture.
- Open menus, selected tabs, expanded sections, and similar UI state should be configured manually before pressing Enter in the authenticated script.
- Cross-origin frames or resources protected by browser or server policies may not be completely preserved.
- Pages that continuously make network requests may cause `waitUntil: 'networkidle'` to time out in the public-page script.

## Troubleshooting

### `Cannot use import statement outside a module`

Add `"type": "module"` to `package.json`, or rename the scripts from `.js` to `.mjs`.

### Chromium executable is missing

Install the Playwright-managed browser:

```bash
npx playwright install chromium
```

### Google Chrome is not installed

`save-page-with-login.js` uses the Playwright `channel: 'chrome'` option. Install Google Chrome, or remove that option to use Playwright's bundled Chromium instead.

### Page loading times out

Increase the `timeout` value passed to `page.goto()`. For a site that continuously sends requests, use `waitUntil: 'load'` instead of `waitUntil: 'networkidle'`.

### Screenshot is missing lazy-loaded content

Scroll through the page before capture so lazy-loaded sections are rendered. With the authenticated script, do this manually before returning to the terminal and pressing Enter.

### The authenticated script asks for login again

Check that `.playwright-profile` still exists and that the script is being run from the same project directory. The website may also have expired or revoked the previous session.

### Chrome reports that the profile is already in use

Close other Chrome or Playwright processes that use `.playwright-profile`, then run the script again.
