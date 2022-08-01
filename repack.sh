# !/bin/bash
# Check 2to3
REQUIRED_PKG="2to3"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG | grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo -e "No $REQUIRED_PKG. Please install $REQUIRED_PKG:\nsudo apt install --yes ${REQUIRED_PKG}"
  exit 1
fi

trap 'rm -rf "$TEMP_DIR_PATH"' EXIT

# Declare some variables
CURR_PWD=$(pwd)
TEMP_DIR_PATH=$(mktemp -d) || exit 1
DOWNLOAD_PATH="https://desktop-download.mendeley.com/download/apt/pool/main/m/mendeleydesktop/mendeleydesktop_1.19.8-stable_amd64.deb"
DOWNLOADED_FILE_NAME="mendeley_origin.deb"
OUTPUT_DEB_NAME="mendeleydesktop_1.19.8_for_ubuntu_22.04.deb"


# Enter the temp directory
cd ${TEMP_DIR_PATH}

# Download deb
wget ${DOWNLOAD_PATH} -O ${DOWNLOADED_FILE_NAME}

# Extract 
ar x ${DOWNLOADED_FILE_NAME}

# Extract the control and data archives.
tar xzf control.tar.gz
tar xf data.tar.xz

# Edit the control file, from python to python3
sed -i "3s/python/python3/g" control

# Convert a python code file in data to python3 format
2to3 -w opt/mendeleydesktop/apt/setup-apt-repository.py

# Repack
tar --ignore-failed-read -cvzf control.tar.gz control
tar cJf data.tar.xz opt usr
ar rcs ${OUTPUT_DEB_NAME} debian-binary control.tar.gz data.tar.xz

# Move the changed deb file
mv ${OUTPUT_DEB_NAME} ${CURR_PWD}

# Delete 
rm -rf ${TEMP_DIR_PATH}

# Echo
echo -e "#######################################\n#######################################"
echo -e "Try to install the repackaged deb:\n sudo dpkg -i ${OUTPUT_DEB_NAME}"
