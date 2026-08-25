#!/usr/bin/env fish
magick banners.png -background Blue -alpha remove -alpha off frame0.png
rm spriteset.txt
set f 14
for i in $(seq 1 $f)
	set filename $(string join '' frame $i .png)
	echo $filename
	magick bannermasktop.png wavemasktop.png -geometry $(string join '' '+0-' $(math 5'*'$i-5)) -compose Multiply -composite outputmasktop.png
	magick bannermaskbottom.png wavemaskbottom.png -geometry $(string join '' '+0-' $(math 5'*'$i-5)) -compose Multiply -composite outputmaskbottom.png
	magick outputmasktop.png outputmaskbottom.png -append outputmask.png
	magick banners.png outputmask.png -compose CopyOpacity -composite frameparttop.png
	magick outputmask.png outputmask.png -geometry +0-1 -compose Multiply -composite outputmask.png
	magick outputmask.png -background Blue -alpha shape outputmask.png
	magick banners.png outputmask.png -compose Over -composite framepartbottom.png
	magick frameparttop.png -crop 100%x50%+0+0 frameparttop1.png
	magick frameparttop.png -crop 100%x50%+0+57 frameparttop2.png
	magick framepartbottom.png frameparttop1.png -geometry +1-1 -composite -background Blue -alpha remove -alpha off $filename
	magick $filename frameparttop2.png -geometry -1+56 -composite $filename
	sed -e $(string join '' 's/p1/' $(math 4+114'*'$i) '/g') -e $(string join '' 's/p2/' $(math 2+114'*'$i) '/g') -e $(string join '' 's/p3/' $(math 60+114'*'$i) '/g') -e $(string join '' 's/p4/' $(math 58+114'*'$i) '/g') -e $(string join '' 's/I/' $i '/g') oneframe.txt >> spriteset.txt
	set i $(math $i + 1)
end
magick frame[0-9].png frame1[0-9].png -append frames.png

