xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitorVirtual-1/workspace0/last-image --set /home/tedy/bg.png
xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set /home/tedy/bg.png
xfconf-query -c xsettings -p /Net/ThemeName -s "Adapta-Nokto"
xfconf-query -c xfwm4 -p /general/workspace_count -s 1
cp /usr/share/applications/visual-studio-code.desktop /home/tedy/Desktop