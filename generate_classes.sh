echo 'Removing all resources in folder Resources'
rm -fR OceanTokens/Classes/OceanExtensions

echo 'Creating Colors folder'
mkdir -p OceanTokens/Classes/OceanExtensions/Colors

echo 'Creating Sizes folder'
mkdir -p OceanTokens/Classes/OceanExtensions/Sizes

echo 'Creating Shadows folder'
mkdir -p OceanTokens/Classes/OceanExtensions/Shadows

echo 'Creating Typography folder'
mkdir -p OceanTokens/Classes/OceanExtensions/Typography

echo 'Check config swiftgen.yml and run'
swiftgen config lint && 
swiftgen config run --verbose && 
swiftgen config run --config swiftgen-shadows.yml  --verbose && 
swiftgen config run --config swiftgen-typography.yml  --verbose && 
swiftgen config run --config swiftgen-installer-fonts.yml  --verbose