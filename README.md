# Azure DevOps URL Redirector

This Edge browser extension automatically redirects old Azure DevOps URLs from the legacy format to the new format:

- **Old format:** `https://{org}.visualstudio.com/{project}/...`
- **New format:** `https://dev.azure.com/{org}/{project}/...`

## How to Install Locally

### Prerequisites
- Microsoft Edge browser (version 79 or later)

### Installation Steps

1. **Open Edge Extensions Page**
   - Open Microsoft Edge
   - Navigate to `edge://extensions/` or click the menu (three dots) → Extensions

2. **Enable Developer Mode**
   - Toggle on "Developer mode" in the bottom-left corner of the extensions page

3. **Load the Extension**
   - Click the "Load unpacked" button
   - Browse to the `AdoRedirectExtension` folder (the folder containing `manifest.json`)
   - Click "Select Folder"

4. **Verify Installation**
   - You should see "Azure DevOps URL Redirector" appear in your extensions list
   - The extension should be enabled by default

5. **Test the Extension**
   - Try navigating to an old Azure DevOps URL like:
     - `https://myorg.visualstudio.com/myproject`
   - It should automatically redirect to:
     - `https://dev.azure.com/myorg/myproject`

## How It Works

The extension uses the Manifest V3 `declarativeNetRequest` API to intercept requests to `*.visualstudio.com` domains and redirect them to the corresponding `dev.azure.com` URL before the page loads.

## Features

- ✅ Automatic redirection before page load (no page flicker)
- ✅ Works with all Azure DevOps subdomains
- ✅ Preserves the full path and query parameters
- ✅ Lightweight and efficient (uses declarative rules)

## Troubleshooting

- **Extension not working:** Make sure the extension is enabled in `edge://extensions/`
- **Still loads old URL:** Clear your browser cache and try again
- **Permission issues:** The extension requires permission to access `*.visualstudio.com` URLs

## Uninstall

1. Go to `edge://extensions/`
2. Find "Azure DevOps URL Redirector"
3. Click "Remove"
