
echo "Generating release version number equals npm version…"
git tag -a "OceanTokens-$1" -m "Release of version $1"
git push --tags

echo "Creating podspec OceanTokens…"
cp -fR OceanTokens.template OceanTokens.podspec 

echo "Putting version number equals npm version…"
sed -i '' "s/#NPM_VERSION#/'$1'/g" OceanTokens.podspec

echo "Creating new pod…"
pod trunk push OceanTokens.podspec  