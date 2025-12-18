# Different Theme Dark Mode Pro Extension

A professional Chrome/Firefox extension for advanced theme management with multiple dark/light mode variations, custom themes, and intelligent auto-switching based on time, website preferences, or system settings.

## different-theme-dark-mode-pro-extension/
├── manifest.json # Extension configuration
├── popup.html # Popup interface
├── popup.css # Popup styling
├── popup.js # Popup functionality
├── content.js # Content script (injects into pages)
├── injected.css # Theme styles for websites
├── icons/ # Extension icons (to add)
│ ├── icon16.png
│ ├── icon48.png
│ └── icon128.png
├── .gitignore # Git ignore rules
├── LICENSE # MIT License
└── README.md # This file


## Installation

### Chrome
1. Download or clone this repository
2. Open Chrome and go to `chrome://extensions/`
3. Enable "Developer mode" (top right)
4. Click "Load unpacked"
5. Select the extension folder

### Firefox
1. Open `about:debugging`
2. Click "This Firefox"
3. Click "Load Temporary Add-on"
4. Select `manifest.json` from the extension folder

## Features

### Theme Variations
- **Dark Modes:** Cool Dark, Warm Dark, True Black, Sepia Dark
- **Light Modes:** Standard Light, Warm Light, Cool Light, Paper
- **Custom Themes:** Create your own color schemes

### Smart Features
- **Auto-switching:** Changes themes based on time of day
- **Per-site preferences:** Different themes for different websites
- **System sync:** Match your operating system theme
- **Scheduled themes:** Set specific themes for specific times

### Customization
- Color picker for all elements
- Contrast adjustment
- Font size customization
- Animation preferences

## Usage

1. Click the extension icon in your browser toolbar
2. Select your preferred theme from the popup menu
3. Enable auto-switch for automatic theme changes
4. Access settings for advanced customization
```bash
git clone https://github.com/PRITIDIPADAS/different-theme-dark-mode-pro-extension.git
cd different-theme-dark-mode-pro-extension
