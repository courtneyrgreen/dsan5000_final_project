# DEFINE PATH
dir1=${PWD}

# CLEAN-UP
rm -rf _site;

# BUILD WEBSITE
quarto render

# CLEAN UP 
cd _site; for i in $(find  ./ -name .DS_Store); do rm $i; done; cd "$dir1"

# SET CORRECT PERMISSIONS FOR ALL FILES 
for i in $(find _site -type f); do chmod 644 $i; done
for i in $(find _site -type d); do chmod 755 $i; done

# PUSH WEBSITE TO GU DOMAINS 
printf 'Would you like to push to GU domains: (y/n)? '
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then 
    #rsync -alvr --delete _site/* crggeorg@15.204.146.110:/home/crggeorg/public_html
    rsync -alvr --delete _site/* crggeorg@crg123.georgetown.domains:/home/crggeorg/public_html
else
    echo NOT PUSHING TO GU DOMAINS!
fi
