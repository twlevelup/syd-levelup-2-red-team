if [[ -d dist ]]; then
	rm -r dist
fi

if [[ -d bin ]]; then
	rm -r bin
fi

mkdir bin
mkdir dist
cp *.lua bin
cp -r vendor bin/vendor
cp -r assets bin/assets
cd bin/
zip -9 -q -r ../dist/levelup.love .
