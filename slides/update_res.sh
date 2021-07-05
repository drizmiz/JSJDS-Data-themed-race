
cd ./resources
cp ../../document/resources/* .

for f in *.pdf; do
  pdf2svg $f ${f%%.*}.svg
done
