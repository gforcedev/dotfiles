# Sum the pagecount of all PDFs in this directory and recursively in subdirectories
find . -name \*.pdf -exec pdfinfo {} \; | grep Pages | sed -e "s/Pages:\s*//g" | awk '{ sum += $1;} END { print sum; }'
