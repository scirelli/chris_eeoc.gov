#!/bin/bash

htmlDocBegin=$(cat <<END
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
    </head>
    <body>
        <ol>
END
)

htmlDocEnd=$(cat <<END
        </ol>
    </body>
</html>
END
)
anchors=""
articleRoot="eeocArticlesHtml"
articleDir=

printf  "Content-type: text/html\n\n"

printf "$htmlDocBegin"

for f in /home/pi/Shares/rpi_0_playground/pi/eeoc.gov/html/*.html; do
    url="/$articleRoot/"`echo "$f" | sed 's/\/home\/pi\/Shares\/rpi_0_playground\/pi\/eeoc.gov\/html\///'`
    printf "<li><a target=\"_blank\" href=\"$url\">$url</a></li>"
done

printf "$htmlDocEnd""
