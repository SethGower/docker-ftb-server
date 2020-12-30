#!/usr/bin/env bash

function grab_deps {
    wget --no-check-certificate https://api.modpacks.ch/public/modpack/$PACK/$VERSION/server/linux -O $INSTALL_FILE
    chmod u+x $INSTALL_FILE
    echo "y" | ./$INSTALL_FILE
    chmod u+x start.sh
}


if [ ! -e version.json ]
then
    grab_deps
else
    if [[ `cat version.json | jq -r '.id'` != "$VERSION" || `cat version.json | jq -r '.parent'` != "$PACK" ]]; 
    then
        grab_deps
    fi
fi

sed -i '/bash\|java/!d' start.sh

if [ $EULA_ACCEPT == true ]
then
    echo "eula=true" > eula.txt
else
    echo "eula=false" > eula.txt
fi

./start.sh
