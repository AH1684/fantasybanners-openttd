#!/usr/bin/env fish
magick banners.png -background Blue -alpha remove -alpha off frame0.png
set f 8
for i in $(seq 1 $f)
	set filename $(string join '' frame $i .png)
	echo $filename
	magick wavemask.png +level-colors Black wavemask.png -geometry $(string join '' '+0-' $(math 5'*'$i-5)) -compose Over -composite wavemask2.png
	magick bannermask.png wavemask2.png -compose Multiply -composite outputmask.png
	magick banners.png outputmask.png -compose CopyOpacity -composite frameparttop.png
	magick outputmask.png outputmask.png -geometry +0-1 -compose Multiply -composite outputmask.png
	magick outputmask.png -background Blue -alpha shape outputmask.png
	magick banners.png outputmask.png -compose Over -composite framepartbottom.png
	magick frameparttop.png -crop 100%x50%+0+0 frameparttop1.png
	magick frameparttop.png -crop 100%x50%+0+57 frameparttop2.png
	magick framepartbottom.png frameparttop1.png -geometry +1-1 -composite -background Blue -alpha remove -alpha off $filename
	magick $filename frameparttop2.png -geometry -1+56 -composite $filename
	set i $(math $i + 1)
end
magick frame[0-9].png -append frames.png
