# Package the theme for Chrome Web Store upload.

zip := "tokyo-night-day-theme.zip"

# Build the Web Store upload zip (manifest.json + icon.png, flat)
publish:
    python3 -c "import json; json.load(open('manifest.json'))"
    rm -f {{zip}}
    zip -j {{zip}} manifest.json icon.png
    @echo "Built {{zip}} — upload at https://chrome.google.com/webstore/devconsole"
