/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install google-authenticator-libpam
brew install pam_yubico
brew install gnu-sed

google-authenticator --force --time-based --disallow-reuse --rate-limit=3 --rate-time=30 --window-size=10

sudo gsed -i '1 i\auth       sufficient     /usr/local/lib/security/pam_google_authenticator.so use_first_pass forward_pass nullok' /etc/pam.d/authorization
sudo gsed -i '$ a\auth       required       /usr/local/lib/security/pam_yubico.so mode=challenge-response' /etc/pam.d/authorization
sudo gsed -i '1 i\auth       sufficient     /usr/local/lib/security/pam_google_authenticator.so use_first_pass forward_pass nullok' /etc/pam.d/screensaver
sudo gsed -i '$ a\auth       required       /usr/local/lib/security/pam_yubico.so mode=challenge-response' /etc/pam.d/screensaver
sudo gsed -i '$ a\auth       sufficient     /usr/local/lib/security/pam_yubico.so mode=challenge-response' /etc/pam.d/sudo
sudo gsed -i '$ a\auth       required       /usr/local/lib/security/pam_google_authenticator.so nullok' /etc/pam.d/sudo

