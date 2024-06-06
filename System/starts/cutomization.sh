#!/bin/sh
export LD_LIBRARY_PATH="/mnt/SDCARD/System/lib:/usr/trimui/lib:$LD_LIBRARY_PATH"
system_json="/mnt/UDISK/system.json"

################ CrossMix-OS internal storage Customization ################

if [ ! -e "/usr/trimui/fw_mod_done" ]; then

	# background remove
	find /mnt/SDCARD/Emus/ -iname config.json -exec sed -i 's/\"background.*\"/\"background\":\"\"/' {} \;

	# add ko language
	cp -f "/mnt/SDCARD/trimui/res/lang/ko.lang" "/usr/trimui/res/lang/"
	cp -f "/mnt/SDCARD/trimui/res/lang/ko.lang.short" "/usr/trimui/res/lang/"
	sed -i 's/\"label.ch.lang.*/\"label.ko.lang\":\"펑션키 설정\",/' /usr/trimui/apps/fn_editor/config.json
	sed -i 's/\"label.ch.lang.*/\"label.ko.lang\":\"문라이트\",/' /usr/trimui/apps/moonlight/config.json
	sed -i 's/\"label.ch.lang.*/\"label.ko.lang\":\"미디어 플레이어\",/' /usr/trimui/apps/player/config.json
	sed -i 's/\"label.ch.lang.*/\"label.ko.lang\":\"USB 저장소\",/' /usr/trimui/apps/usb_storage/config.json

	# modifying default theme to impact all other themes (Better game image background)
	mv "/usr/trimui/res/skin/ic-game-580.png" "/usr/trimui/res/skin/ic-game-580_old.png"
	cp "/mnt/SDCARD/trimui/res/skin/ic-game-580.png" "/usr/trimui/res/skin/ic-game-580.png"

	# Removing duplicated app
	rm -rf /usr/trimui/apps/zformatter_fat32/

	# Apply default CrossMix theme, sound volume, and grid view
	cp /mnt/SDCARD/System/usr/trimui/scripts/MainUI_default_system.json /mnt/UDISK/system.json
	# sed -i "s|\"theme\":.*|\"theme\": \"/mnt/SDCARD/Themes/CrossMix - OS/\",|" "$system_json"

	################ CrossMix-OS SD card Customization ################

	# Displaying only Emulators with roms if the Emus list is not already customized
	if [ ! -e "/mnt/SDCARD/Emus/show.json" ]; then
		/mnt/SDCARD/Apps/EmuCleaner/launch.sh -s
	fi


	touch "/usr/trimui/fw_mod_done"
	sync
fi

######################### CrossMix-OS at each boot #########################

# Apply current led configuration
#/mnt/SDCARD/System/etc/led_config.sh &

#pkill -f sdl2imgshow
