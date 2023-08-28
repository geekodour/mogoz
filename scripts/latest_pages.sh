#!/usr/bin/env bash

# Why sort by commit date instead of disk modified date?
# - Sorting by modified date would not suffice, it will sort files based on disk
#   save timestamp. Sometimes I save file without any change out of habit. This
#   is problematic.
# - So the way sort this would be by commit date
# Usage:
# - ./latest_pages.sh > filename.html
#
pushd ../content/posts > /dev/null || exit
echo "<html>"
echo "<head>"
# echo '<link rel="stylesheet" href="https://unpkg.com/mvp.css@1.12/mvp.css">'
echo "</head>"
echo "<body>"
echo "pages: $(ls | wc -l)"
echo "<table>"
echo "<tr><th>Last Modified</th><th>File</th></tr>"
git ls-tree -r --name-only HEAD | while read -r filename; do
  printf "<tr><td>%s</td><td><a href='%s' target='_blank' rel='noreferrer noopener'>%s</a></td></tr>\n" "$(git log -1 --format="%cs" $filename)" "/posts/${filename:0:-3}" "${filename:15:-3}"
done | sort -r
echo "</table>"
echo "</body>"
echo "</html>"
popd > /dev/null || exit
