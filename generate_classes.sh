echo '\033[1;31m Downloading tokens into npm lib…\033[0m'
yarn add -D @useblu/tokens@2.0.0-alpha.1

echo '\033[1;31m Removing all resources in folder Resources…\033[0m'
rm -fR OceanTokens/Classes/OceanExtensions

echo '\033[1;31m Creating Colors folder…\033[0m'
mkdir -p OceanTokens/Classes/OceanExtensions/Colors

echo '\033[1;31m Creating Sizes folder…\033[0m'
mkdir -p OceanTokens/Classes/OceanExtensions/Sizes

echo '\033[1;31m Creating Shadows folder…\033[0m'
mkdir -p OceanTokens/Classes/OceanExtensions/Shadows

echo '\033[1;31m Creating Typography folder…\033[0m'
mkdir -p OceanTokens/Classes/OceanExtensions/Typography

echo '\033[1;31m Checking config swiftgen.yml and run…\033[0m'
swiftgen config lint --config swiftgen-colors-and-sizes.yml && 
swiftgen config run --config swiftgen-colors-and-sizes.yml  --verbose && 
swiftgen config lint --config swiftgen-shadows.yml && 
swiftgen config run --config swiftgen-shadows.yml  --verbose && 
swiftgen config lint --config swiftgen-typography.yml  && 
swiftgen config run --config swiftgen-typography.yml  --verbose && 
swiftgen config lint --config swiftgen-installer-fonts.yml  && 
swiftgen config run --config swiftgen-installer-fonts.yml  --verbose

echo '\033[1;31m Copying Fonts ttf to Resources into OceanTokens…\033[0m'
rm -fR ./OceanTokens/Resources/Fonts
mkdir -p ./OceanTokens/Resources/Fonts
cp  -pR  ./node_modules/@useblu/tokens/dist/assets/fonts/* ./OceanTokens/Resources/Fonts