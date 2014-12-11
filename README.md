colortag
========

Provide color tagging for files (like in Mac OS X) for Ubuntu. 

Requires: 
  realpath
  convert and composite from imagemagic package
  uses gvfs-set-attribute

Works for nautilus. If other managers use gfvs then it might work for them too. 
Creates a .colortag folder in your home. 

Usage: color-tag <color> <filepath>
<color> can be anything in http://www.imagemagick.org/script/color.php
<filepath> is relative or absolute path to your file
Remember to hit F5 key to refresh nautilus so it will display the changes.


