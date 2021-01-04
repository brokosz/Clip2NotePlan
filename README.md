# Clip2NotePlan PopClip extension

An extension for [PopClip](http://pilotmoon.com/popclip) to take web and plain text and add to [NotePlan app](https://noteplan.co/), keeping as much of the formatting as NotePlan allows. Note:

- this only works on web content - not source code
- it creates a few lines of header that includes the web page title, source and date of clipping
- it imports any images though this hasn't been well tested ...

## Usage
Highlight part of a web page or email client (or other source with underlying HTML), and on the little PopClip menubar that appears either:
- click the NotePlan star icon <img src="NotePlan.png">. This copies the text and any images, and adds them to the end of the current daily note. 
- ⌘-click the NotePlan star icon. This copies the text and any images, and adds them as a top-level new note in NotePlan.

## Installation
Download the Web2NotePlan.popclipext extension, and then double-click it to add it to PopClip. 
By default, PopClip will display a warning dialog when you try to install your own extension, because it is not digitally signed by Pilotmoon Software:

![Example unsigned warning.](https://camo.githubusercontent.com/27eeba66f14bdc1fbe97f9c0ea3a29be0ba815a1e9cee285b0a877a157d167e8/68747470733a2f2f7261772e6769746875622e636f6d2f70696c6f746d6f6f6e2f506f70436c69702d457874656e73696f6e732f6d61737465722f646f63732f6578745f7761726e696e672e706e67)

This is normal, and you should click "Install ...". (PopClip stores its installed extensions in `~/Library/Application Support/PopClip/Extensions/`.)

It will then show you a little dialog to set the available options:

- Open the new note? *When a new note is made, do you want NotePlan to display it?*
- Open in a new window? *If you want to open a new note, do you want to appear in a new window, or the current one?*
- Add date to header? *Only relevant when a new note is made.*
- Tag that's appended to show source (optional). *I set this to `#PopClipped` to show where it comes from.*

## Credits
This extension uses:

- [html2text](https://pypi.python.org/pypi/html2text/3.200.3) by Aaron Swartz. (GPL 3 licensed, see `COPYING`) to convert HTML to Markdown. Note that this version is many years old, but it's the latest version I can find that is a single file that can easily be included and run within the constraints of a PopClip extension. (Current versions are at https://pypi.org/project/html2text/.)
- two one-line Perl scripts to encode and decode the markdown to pass to NotePlan.

Hat-tip to Brett Terpstra whose [Web Markdownifier](http://brettterpstra.com/2013/12/23/web-markdownifier-for-popclip/) extension inspired the "Copy as Markdown" extension that this was forked from, by Jonathan Clark and Brad Rokosz.  And of course big thanks to Eduard Metzger who develops the amazing [NotePlan app](https://noteplan.co/).
