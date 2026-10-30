-- Desktop brightness (external monitors over DDC/CI)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[ddcutil setvcp 10 + 5 && notify-send "Brightness" "$(ddcutil getvcp 10 | awk '/Brightness/ {gsub(/,/, "", $9); print $9}')%"]]), { repeating = true, description = "Increase brightness" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[ddcutil setvcp 10 - 5 && notify-send "Brightness" "$(ddcutil getvcp 10 | awk '/Brightness/ {gsub(/,/, "", $9); print $9}')%"]]), { repeating = true, description = "Decrease brightness" })
