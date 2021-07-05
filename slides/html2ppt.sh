
R -e 'pagedown::chrome_print("slides.html")'

mkdir ./temp_jpg/
gs -dNOPAUSE -dBATCH -dSAFER -dGraphicsAlphaBits=4 -dTextAlphaBits=4 -sDEVICE=jpeg -r300 -sOutputFile='temp_jpg/page-%00d.jpg' slides.pdf

read -p "Open LibreOffice to generate ppt from jpg. Then press [ENTER] to resume..."

rm --recursive ./temp_jpg/
