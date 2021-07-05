
mkdir ./temp_jpg/
gs -dNOPAUSE -dBATCH -dSAFER -dGraphicsAlphaBits=4 -dTextAlphaBits=4 -sDEVICE=jpeg -r300 -sOutputFile='temp_jpg/page-%00d.jpg' slides.pdf

read -p "Open LibreOffice to generate the pdf from jpg. Then press any key to resume..."

rm --recursive ./temp_jpg/
