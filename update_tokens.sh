

echo '\033[1;31m Downloading tokens into npm lib…\033[0m'
yarn add -D @useblu/ocean-tokens

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
rm -fR ./OceanTokens/Resources/Fonts &&
mkdir -p ./OceanTokens/Resources/Fonts &&
cp  ./node_modules/@useblu/ocean-tokens/assets/fonts/**/* ./OceanTokens/Resources/Fonts
