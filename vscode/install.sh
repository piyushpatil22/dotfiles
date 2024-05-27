#!/usr/bin/zsh

new_ext="installed-extension-list"

#update repo extension list with currently installed exts
if [[ $1 == "--update" ]]; then
    echo "Updating repo with new extensions"
    code --list-extensions > $new_ext
    return 0
fi

#install new extensions if found in the repo $new_ext list
old_ext=".old_ext"
new_list=".diff_list"

$(code --list-extensions > $old_ext)
$(comm -23 $new_ext $old_ext > $new_list)

diff_list=$(cat .diff_list)

if [[ ! -z $diff_list ]]; then
    echo "Found new exntensions that are not installed on current system"
    cat .diff_list | while IFS= read -r ext
    do
        echo "Now Installing $ext ..."
        code --install-extension $ext
    done
else
    echo "No new extensions found"
fi

rm $old_ext
rm $new_list
