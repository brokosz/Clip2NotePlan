define(function () {
    var extension = {
        action: function (selection, context, options, modifierKeys) {
            var openNote = options.opennote ? "yes" : "no";
            var subWindow = options.subwindow ? "yes" : "no";
            var content = selection.markdown;
            if (options.addsource) {
                content += "\nsource: " + (context.browserUrl ? context.browserUrl : context.appName);
            }
            if (options.adddate) {
                content += "\n" + new Intl.DateTimeFormat().format(Date.now());
            }
            if (options.addtag) {
                content += "\n#" + options.addtag;
            }
            if (modifierKeys === 0) {
                // If no modifier key was pressed, then create a new note, with header                
                popclip.openUrl("noteplan://x-callback-url/addNote?text=" + encodeURIComponent(content) + "&openNote=" + openNote + "&subWindow=" + subWindow);
            }
            else {
                // todo :)
            }
        }
    };
    return extension;
});
