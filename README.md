colortag
========

Provide color tagging for files (like in Mac OS X) for Ubuntu. 

Requires: 
  `realpath`
  `convert` and `composite` from `imagemagic` package
  uses `gvfs-set-attribute`

Works for nautilus. If other managers use gfvs then it might work for them too. 
Creates a .colortag folder in your home. 

Usage: `color-tag <color> <filepath>`

__color__ can be anything in http://www.imagemagick.org/script/color.php

__filepath__ is relative or absolute path to your file

Remember to hit F5 key to refresh nautilus so it will display the changes.


Usefull links:

* http://rlog.rgtti.com/2010/11/28/adding-a-gnomenautilus-thumbnailer/
* http://www.imagemagick.org/script/color.php
* http://askubuntu.com/questions/308045/differences-between-bin-sbin-usr-bin-usr-sbin-usr-local-bin-usr-local
* http://askubuntu.com/questions/266322/what-additional-thumbnailers-are-available-and-how-do-i-install-them?rq=1
* http://askubuntu.com/questions/79110/how-can-i-assign-custom-icons-to-folders
* http://askubuntu.com/questions/6009/where-are-icons-stored
* http://askubuntu.com/questions/160971/cant-generate-thumbnails-in-nautilus?rq=1
* http://askubuntu.com/questions/36945/command-line-thumbnailing
* http://askubuntu.com/questions/199110/how-can-i-instruct-nautilus-to-pre-generate-thumbnails?rq=1
* http://askubuntu.com/questions/153575/where-does-gnome-nautilus-store-directory-icons
* http://askubuntu.com/questions/217757/how-can-i-programmatically-change-a-files-icon
* http://askubuntu.com/questions/287600/thumbnails-nautilus-previews-for-basic-xpm-png-bmp-gif-image-files?rq=1
