# Web2NotePlan PopClip extension

An extension for PopClip to take web text and make a new NotePlan note from it, keeping as much of the formatting as NotePlan allows. Note:
- this only works on web content - not source code
- it creates a few lines of header that includes the web page title and source
- it imports any images though this hasn't been well tested ...

This extension uses
- [html2text](https://pypi.python.org/pypi/html2text/3.200.3) by Aaron Swartz. (GPL 3 licensed, see `COPYING`) to convert HTML to Markdown. Note that this version is many years old, but it's the latest version I can find that is a single file that can easily be included and run within the constraints of a PopClip extension. (Current versions are at https://pypi.org/project/html2text/.)
- a one-line Perl script [from another PopClip extension](https://github.com/pilotmoon/PopClip-Extensions/blob/master/source/URLEncode/urlencode.sh) to encode the markdown to pass to NotePlan.

Hat-tip to Brett Terpstra whose [Web Markdownifier](http://brettterpstra.com/2013/12/23/web-markdownifier-for-popclip/) extension inspired the "Copy as Markdown" extension that this was forked from, by Jonathan Clark and Brad Rokosz.  And of course big thanks to Eduard Metzger who develops the amazing [NotePlan app](https://noteplan.co/).

## TODO
- get the Option mechanism working. See commented out code in `Config.plist` and `html2md.sh`.
- add more information to the header (if possible)
