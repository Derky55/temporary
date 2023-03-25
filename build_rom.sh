# sync rom

repo init --depth=1 --no-repo-verify -u repo init -u repo init -u https://github.com/LineageOS/android.git -b lineage-19.1 -g default,-mips,-darwin,-notdefault

git clone https://github.com/Prettysir/local_manifest.git --depth 1 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#17

# build rom

source build/envsetup.sh

export ALLOW_MISSING_DEPENDENCIES=true

export SELINUX_IGNORE_NEVERALLOWS=true

export TZ=Asia/Dhaka #put before last build command

lunch lineage_x00qd-userdebug

make bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)

rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

