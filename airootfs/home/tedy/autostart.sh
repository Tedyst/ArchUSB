# Depends where it's run
xfconf-query --channel xfce4-desktop --list | grep last-image | while read path; do
    xfconf-query --channel xfce4-desktop --property $path --set /home/tedy/bg.png
done

xfconf-query -c xsettings -p /Net/ThemeName -s "Adapta-Nokto"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"
xfconf-query -c xfwm4 -p /general/workspace_count -s 1

cp /usr/share/applications/visual-studio-code.desktop /home/tedy/Desktop
chmod +x /home/tedy/Desktop/visual-studio-code.desktop

cp /usr/share/applications/firefox-esr.desktop /home/tedy/Desktop
chmod +x /home/tedy/Desktop/firefox-esr.desktop

# Set the default browser to firefox
xdg-settings set default-web-browser firefox-esr.desktop