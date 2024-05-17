KEYBOARD=keychron-keychron-q2-pro
PT=Portuguese
US='English (US)'

RES=$(hyprctl -j devices | jq -r '.["keyboards"][] | select(.name == "'$KEYBOARD'") | ."active_keymap"')

case $RES in
	$PT)
		Layout=PT
		;;
	$US)
		Layout=US
		;;
	*)
		Layout=Other
		;;
esac

echo "{ \"alt\": \"${Layout}\", \"tooltip\": \"${RES}\" }"


