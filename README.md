# Goodreads Command Line Interface
📚📚📚 Command-line tool that displays two random books in your currently-reading and to-read shelves on goodreads.com

![screenshot](https://i.imgur.com/HCE7Ish.png "In action")

## Usage
To use, you need an api key from goodreads: https://www.goodreads.com/api/keys and the userid of the user whose lists you would like to use.
Then run:
```
$ export goodreadskey="<your key here>" && export goodreadsid="<your user id here>"
```
Install dependencies with ` cpanm --installdeps ` from the cpanfile. Uses Perl v5.22.1

You can run the script using:
```
$ ./getbooks.sh
```
Using your developer key and your userid, it `curl`s all the books on all the user's shelves, outputs them into a file named books.xml, and parses the file for the name, author name, description, page numbers, and year published (if these attributes don't exist on goodreads, it won't output anything). It takes two random books from each list (if one of the lists has less than 2, it'll output everything it contains). Uses ANSI colours to get colour output.  
