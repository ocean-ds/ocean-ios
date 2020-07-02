echo 'Removing all resources in folder Resources'
rm -fR Resources

echo 'Creating Colors folder'
mkdir -p Resources/Colors

echo 'Check config swiftgen.yml and run'
swiftgen config lint && 
swiftgen config run --verbose && 
swiftgen config run --config swiftgen-shadows.yml  --verbose && 
swiftgen config run --config swiftgen-typography.yml  --verbose && 
swiftgen config run --config swiftgen-installer-fonts.yml  --verbose