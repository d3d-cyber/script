echo "=========================================="
echo "🦊 Removing Snap Firefox & Installing Native"
echo "=========================================="

echo "-> Step 1: Removing the Snap version of Firefox..."
sudo snap remove firefox || echo "Firefox snap already removed."

echo "-> Step 2: Creating keyring directory..."
sudo install -d -m 0755 /etc/apt/keyrings

echo "-> Step 3: Importing Mozilla APT repository key..."
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

echo "-> Step 4: Adding Mozilla repository..."
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee /etc/apt/sources.list.d/mozilla.list > /dev/null

echo "-> Step 5: Pinning repository to prioritize Mozilla over Ubuntu Snap..."
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla > /dev/null

echo "-> Step 6: Updating APT and installing native Firefox..."
sudo apt update
sudo apt install -y firefox

echo "=========================================="
echo "✅ Installation complete! You can now launch Firefox."
echo "=========================================="
