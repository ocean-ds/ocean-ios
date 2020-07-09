LATEST_VERSION_TOKENS_LIB_NPM=`npm show  @useblu/tokens version` 
echo "version:$LATEST_VERSION_TOKENS_LIB_NPM"
echo "Generating release version number equals npm version…"
git tag -a "OceanTokens-$LATEST_VERSION_TOKENS_LIB_NPM" -m "Release of version $LATEST_VERSION_TOKENS_LIB_NPM"
git push --tags

echo "Creating podspec OceanTokens…"
cp -fR OceanTokens.template OceanTokens.podspec 

echo "Putting version number equals npm version…"
sed -i '' "s/#NPM_VERSION#/'$LATEST_VERSION_TOKENS_LIB_NPM'/g" OceanTokens.podspec

echo "Creating new pod…"
pod trunk push OceanTokens.podspec  