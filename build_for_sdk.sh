#!/bin/sh
xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="\$(inherited) -fembed-bitcode -DSQLITE_HAS_CODEC" ARCHS="arm64 arm64e" ONLY_ACTIVE_ARCH=NO PLATFORM_NAME=iphoneos -configuration Release -project GRDB.xcodeproj -target GRDBiOS clean install
if [ -d "build/UninstalledProducts/iphoneos/GRDB.framework" ]; then
    mv build/UninstalledProducts/iphoneos .
fi

xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="\$(inherited) -fembed-bitcode -DSQLITE_HAS_CODEC" ARCHS="x86_64" ONLY_ACTIVE_ARCH=NO PLATFORM_NAME=iphonesimulator -configuration Release -sdk iphonesimulator -project GRDB.xcodeproj -target GRDBiOS clean install
if [ -d "build/UninstalledProducts/iphonesimulator/GRDB.framework" ]; then
    mv build/UninstalledProducts/iphonesimulator .
fi

# xcodebuild BITCODE_GENERATION_MODE=bitcode OTHER_CFLAGS="\$(inherited) -fembed-bitcode -DSQLITE_HAS_CODEC" ONLY_ACTIVE_ARCH=NO -destination "generic/platform=macOS,variant=Mac Catalyst,name=Any Mac" -derivedDataPath "./build-catalyst" -configuration Release -project GRDB.xcodeproj -scheme GRDBiOS clean build
if [ -d "./build-catalyst/Build/Products/Release-maccatalyst/GRDB.framework" ]; then
    mv build-catalyst/Build/Products/Release-maccatalyst .
fi

xcodebuild -create-xcframework -output GRDB.xcframework \
    -framework iphoneos/GRDB.framework \
    -framework iphonesimulator/GRDB.framework # \
#    -framework Release-maccatalyst/GRDB.framework

