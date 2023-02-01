# sync rom
repo init -u https://github.com/Sa-Sajjad/android_manifest_nusa -b 10
git clone https://github.com/Sa-Sajjad/manifest.git --depth 1 -b main .repo/local_manifests
repo sync -c --force-sync --no-tags --no-clone-bundle

# build rom
source build/envsetup.sh
lunch nad_lavender-userdebug
export TZ=Asia/Dhaka #put before last build command
mka nad -j

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
