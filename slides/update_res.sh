
cd ./resources/
cp ../../document/resources/* ./
rm ./*.{bib,csl,tex}

for f in *.pdf; do
  pdf2svg $f ${f%%.*}.svg
done

rm ./*.pdf

cp ../../visualization/out/* ./html/
