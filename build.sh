if [[ -d dist ]]; then
	rm -r dist
fi
mkdir dist
cp *.lua dist
cp -r vendor dist/vendor
cp -r assets dist/assets
cd dist/
zip -9 -q -r levelup.love .
