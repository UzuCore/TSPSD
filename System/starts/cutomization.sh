#!/bin/sh
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/trimui/lib:$LD_LIBRARY_PATH"
system_json="/mnt/UDISK/system.json"

# Screenshot Alias
#alias shot="/usr/trimui/bin/fbscreencap $(date '+%Y%m%d%H%M%S').png"

################ CrossMix-OS internal storage Customization ################

if [ ! -e "/usr/trimui/fw_mod_done" ]; then

	# Removing duplicated app
	rm -rf /usr/trimui/apps/zformatter_fat32/

	# modifying default theme to impact all other themes (Better game image background)
	mv "/usr/trimui/res/skin/ic-game-580.png" "/usr/trimui/res/skin/ic-game-580_old.png"
	cp "/mnt/SDCARD/trimui/res/skin/ic-game-580.png" "/usr/trimui/res/skin/ic-game-580.png"

	# modifying FN cpu script (don't force slow cpu, only force high speed when FN is set to ON) (and we set it as default)
	cp /mnt/SDCARD/System/usr/trimui/res/apps/fn_editor/com.trimui.cpuperformance.sh /usr/trimui/apps/fn_editor/com.trimui.cpuperformance.sh
	cp /mnt/SDCARD/System/usr/trimui/res/apps/fn_editor/com.trimui.cpuperformance.sh /usr/trimui/scene/com.trimui.cpuperformance.sh

	# Apply default CrossMix theme, sound volume, and grid view
	cp /mnt/SDCARD/System/usr/trimui/scripts/MainUI_default_system.json /mnt/UDISK/system.json
	# sed -i "s|\"theme\":.*|\"theme\": \"/mnt/SDCARD/Themes/CrossMix - OS/\",|" "$system_json"

	# background remove
	find /mnt/SDCARD/Emus/ -iname config.json -exec sed -i 's/\"background.*\"/\"background\":\"\"/' {} \;

	# add ko language
	cp -f "/mnt/SDCARD/trimui/res/lang/ko.lang" "/usr/trimui/res/lang/"
	cp -f "/mnt/SDCARD/trimui/res/lang/ko.lang.short" "/usr/trimui/res/lang/"
	sed -i 's/\"label.ch.lang.*/\"label.ko.lang\":\"펑션키 설정\",/' /usr/trimui/apps/fn_editor/config.json
	sed -i 's/\"label.ch.lang.*/\"label.ko.lang\":\"문라이트\",/' /usr/trimui/apps/moonlight/config.json
	sed -i 's/\"label.ch.lang.*/\"label.ko.lang\":\"미디어 플레이어\",/' /usr/trimui/apps/player/config.json
	sed -i 's/\"label.ch.lang.*/\"label.ko.lang\":\"USB 저장소\",/' /usr/trimui/apps/usb_storage/config.json

	# fnkey ko language
	cp -f "/mnt/SDCARD/trimui/res/bg.png" "/usr/trimui/apps/fn_editor/skin/"
	cp -f "/mnt/SDCARD/trimui/res/fn_editor/scripts.json" "/usr/trimui/apps/fn_editor/"
	cp -f "/mnt/SDCARD/trimui/res/NanumSquareNeo-cBd.ttf" "/usr/trimui/apps/fn_editor/DingTalkJinBuTi-Regular.ttf"
	
	# usb storage bg ko language
	cp -f "/mnt/SDCARD/trimui/res/usb_storage/bg.png" "/usr/trimui/apps/usb_storage/"

	# we set the customization flag
	touch "/usr/trimui/fw_mod_done"
	sync

	################ CrossMix-OS SD card Customization ################

	# Displaying only Emulators with roms
	#/mnt/SDCARD/Apps/EmuCleaner/launch.sh -s
fi

######################### CrossMix-OS at each boot #########################

# Apply current led configuration
#/mnt/SDCARD/System/etc/led_config.sh &

#pkill -f sdl2imgshow
