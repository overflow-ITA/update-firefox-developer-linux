#!/bin/bash

# Source reference: https://www.rogerpence.com/posts/a-bash-script-to-install-firefox-dev-edition

function installFFDE {
	cd ~/Downloads
	ffdFile= firefox-*.tar.bz2
	tar -xvf $ffdFile
	mv firefox firefox-developer
	sudo cp -r firefox-developer/ /opt/
	echo "files were copied into /opt/"
	rm -r firefox-developer && rm -r $ffdFile
	echo "All files were removed, your're good to go"
}

function downloadAndInstallFFDE {
	curl -o releases.txt https://download-installer.cdn.mozilla.net/pub/devedition/releases/
	echo "Downloaded..."
	latest=$(grep -o '[0-9][0-9]\.[0-9][a-z][0-9]' releases.txt | tail -1)  
	echo "getting latest release...\nthe latest release is:\nfirefox-$latest.tar.bz2" 
	echo "got latest version"
	ffdFile=firefox-$latest.tar.bz2
	rm releases.txt
	curl -o $ffdFile https://download-installer.cdn.mozilla.net/pub/devedition/releases/$latest/linux-x86_64/en-US/$ffdFile
	echo "got latest version. Proceeding to install it"
	tar -xvf $ffdFile
	mv firefox firefox-developer
	sudo cp -r firefox-developer/ /opt/
	echo "files were copied into /opt/"
	rm -r firefox-developer && rm -r $ffdFile
	echo "All files were removed, your're good to go"
}

FILE=firefox-*.tar.bz2

if [ -e $FILE ]; then
	installFFDE
else 
	echo "installation file does not exists, will start downloading it now..."
	downloadAndInstallFFDE
fi