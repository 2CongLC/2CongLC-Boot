============
gfxboot.cfg
============

boot_show (default: 0)
if set to 1, show the "Boot Options" box. As grub4dos currently don't use this feature, it might be better to hide it.

xmenu_hide_current (default: 0)
if set to 1, hide the current selection item below the bottom menu.

menu_start_x, menu_start_y
Position of menu

menu_max_entries (default: 8)
Maximum number of menu entry to display.

menu_bar_min_width
The minimum width of menu select bar.

menu_text_normal
Normal text color, use RGB value such as 0xffffff.

menu_text_select
Color of selected text

boot_text_options
Color of boot options label

boot_text_normal
Color of boot options text

infobox_bg
Background color of info box

infobox_text_normal
Text color of info box

menu_bar_color
Color of menu bar

loading_color
Color of load bar

title_bg
Background color of dialog background

hide_reboot (default: 0)
If set to 1, hide the reboot button (F9)

hide_poweroff (default: 0)
If set to 1, hide the poweroff button (F10)

disable_num_key (default: 0)
This message file has added keyboard shortcut function, for example, pressing '1' would choose the first menu item. If you don't want it, set this variable to 1.

hide_help (default: 0)
If set to 1, hide the help button (F1)

hide_lang (default: 0)
If set to 1, hide the language button (F2)

custom_width, custom_height, custom_depth
By default, the screen resolution is 800x600x16, if you want a higher resolution, set these three variables, for example:
custom_width=1024
custom_height=768
custom_depth=16
The mode must be supported by bios, otherwise, it just fallback to default.

panel_normal
Color of panel text

panel_title
Color of panel title

panel_high
Color of panel hotkey (Fn)

panel_bg
Background color of panel pop-up box

panel_border
Border color of panel pop-up box

http://www.boot-land.net/forums/index.php?showtopic=7155#