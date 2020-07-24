#set error
set -e

LATEST_VERSION_TOKENS_LIB_NPM=`npm show  @useblu/tokens version` 
echo "Lib in npm - version:$LATEST_VERSION_TOKENS_LIB_NPM"

echo "Executing script for generate classes…"
sh generate_classes.sh

echo "Creating podspec OceanTokens…"
cp -fR OceanTokens.template OceanTokens.podspec 

echo "Putting version number equals npm version…"
sed -i '' "s/#NPM_VERSION#/'$LATEST_VERSION_TOKENS_LIB_NPM'/g" OceanTokens.podspec

echo "Add and Commit new classes"
git add . && git commit -am "Generating classes based npm lib version: $LATEST_VERSION_TOKENS_LIB_NPM"
git push origin master
#git push --set-upstream origin ${CIRCLE_BRANCH}
#git config --global user.name "Alex Gomes"
#git config --global user.email alexandro.gomes@useblu.com.br


echo "Generating release version number equals npm version…"
git tag -a "OceanTokens-$LATEST_VERSION_TOKENS_LIB_NPM" -m "Release of version $LATEST_VERSION_TOKENS_LIB_NPM"
git push --tags

echo "Creating new pod…"
pod trunk push OceanTokens.podspec  
