#!/bin/bash

IOTD_DIR=$HOME/iotd
IMG_LINK=$IOTD_DIR/iotd

mkdir -p $IOTD_DIR

RSS_URL="https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss"
RSS_FILE=$IOTD_DIR/rss.xml
wget --output-document $RSS_FILE $RSS_URL

XPATH="string(/rss/channel/item[1]/enclosure/@url)"
IMG_URL=$(xmllint --xpath $XPATH $RSS_FILE)
IMG_FILE=$IOTD_DIR/$(basename $IMG_URL)
wget --continue --output-document $IMG_FILE $IMG_URL

# Create a symbolic to easily access the last IOTD
# First remove old one
rm -f $IMG_LINK
ln --symbolic $IMG_FILE $IMG_LINK
