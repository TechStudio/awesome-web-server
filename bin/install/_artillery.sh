# install artillery

# requirements
apt-get update

command -v git > /dev/null 2>&1 || { echo >&2 "Git not installed, install git and try again"; exit 1; }

# get the files
git clone https://github.com/trustedsec/artillery /usr/local/src/artillery
echo "\n\n### awesome ### Answer yes to each prompt\n\n"
export PATH=$PATH:/usr/local/src/artillery/
setup.py

echo "\n\n### awesome ### if you received errors during the installation, run _artillery-2.sh\n\n"
