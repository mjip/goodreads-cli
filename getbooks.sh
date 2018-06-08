#!/bin/bash

# assumes you have first executed $ export goodreadskey="<your key here>" and 
# $ export goodreadsid="<your user id here>"

curl "https://www.goodreads.com/review/list?v=2&id=${goodreadsid}&key=${goodreadskey}" > books.xml
./bookscript.pl