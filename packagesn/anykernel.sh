# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=-Elite
do.devicecheck=1
do.initd=1
do.system=1
do.cleanup=1
do.cleanuponabort=0
device.name1=shamu
} # end properties

# shell variables
block=/dev/block/platform/msm_sdcc.1/by-name/boot;
is_slot_device=0;

## end setup


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk
chmod 640 $ramdisk/fstab.shamu
#chmod 750 $ramdisk/init.rc
#chmod 750 $ramdisk/init.shamu.rc
chmod 750 $ramdisk/init.shamu.power.rc


## AnyKernel install
dump_boot;

# begin ramdisk changes

# default.prop
# backup_file default.prop;
# replace_line default.prop "ro.adb.secure=0" "ro.adb.secure=1";
# replace_line default.prop "ro.adb.secure=1" "ro.adb.secure=1";
# replace_line default.prop "ro.secure=0" "ro.secure=1";
# replace_line default.prop "ro.secure=1" "ro.secure=1";
# append_file default.prop ro.adb.secure=1 default

# backup then replace fstab and shamu.power.rc
# backup_file fstab.shamu;
# backup_file init.shamu.rc;
# backup_file init.shamu.power.rc;
replace_file fstab.shamu $ramdisk/fstab.shamu;
#replace_file init.rc $ramdisk/init.rc;
#replace_file init.shamu.rc $ramdisk/init.shamu.rc;
replace_file init.shamu.power.rc $ramdisk/init.shamu.power.rc;

# init.rc
# backup_file init.rc;
append_file init.rc "run-parts" init;
append_file init.shamu.rc "swapon_all" initshamu;

# end ramdisk changes

write_boot;

## end install
