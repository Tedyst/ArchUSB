# Verify that it works
curl https://www.eicar.org/download/eicar.com.txt | clamscan -
# Scan /mnt
clamscan --recursive --infected --remove /mnt