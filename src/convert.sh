
for f in figures/*.pdf
do
    convert -density 300x300 $f $f.png
done

cp figures/*.png ~/Dropbox/Public/tools/exemd
