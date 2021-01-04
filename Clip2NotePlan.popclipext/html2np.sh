#!/bin/bash

# From PopClip get the markdown from the HTML
MD=`echo $POPCLIP_HTML | ./html2text.py`

# Default to not opening new note, unless the option is set to yes
OPEN_NOTE="no"
if [ "$POPCLIP_OPTION_OPENNOTE" == "1" ]; then
	$OPEN_NOTE="yes"
fi
# Default to not opening new note in new window, unless the option is set to yes
SUB_WINDOW="no"
if [ "$POPCLIP_OPTION_SUBWINDOW" == "1" ]; then
	$SUB_WINDOW="yes"
fi
# Include source if it's asked for in options
CLIP_SOURCE=""
if [ -n "$POPCLIP_BROWSER_URL" ]; then
	$CLIP_SOURCE=`echo $POPCLIP_BROWSER_URL`
fi
# Work out date if requested to add date to headers
CLIP_DATE=""
if [ "$POPCLIP_OPTION_ADDDATE" == "1" ]; then
	$CLIP_DATE=`date +"%Y-%m-%d %T"`
fi
# Get clip tag to append if it's asked for in options
CLIP_TAG=""
if [ -n "$POPCLIP_OPTION_ADDTAG" ]; then
	$CLIP_TAG=`echo $POPCLIP_OPTION_ADDTAG`
fi

# FYI, POPCLIP_MODIFIER_FLAGS of 1048576 = ⌘ pressed

# If no modifier key was pressed, then create a new note, with header
if [[ "$POPCLIP_MODIFIER_FLAGS" -eq 0 ]]; then
	
	# Make a little header ... could be extended
	if [ -n "$POPCLIP_BROWSER_TITLE" ]; then
		HEADER="# $POPCLIP_BROWSER_TITLE\nsource: $CLIP_SOURCE\ndate: $CLIP_DATE\n#$CLIP_TAG\n"
		MD_OUT="$MD"
	else
		MD_OUT="$MD\n$CLIP_TAG"
	fi

	# Decode HTML entities (if present)
	MD_OUT_DECODED=`echo "$MD_OUT" | perl -n -mHTML::Entities -e ' ; print HTML::Entities::decode_entities($_) ;'`
	# URL %-encode the header + markdown
	MD_OUT_ENCODED=`echo "$HEADER\n$MD_OUT_DECODED" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'`

	# Send this to NotePlan to create a new note with
	open "noteplan://x-callback-url/addNote?text=$MD_OUT_ENCODED&openNote=$OPEN_NOTE&subWindow=$SUB_WINDOW"

else
	# A modifier key was pressed, then append the markdown to the daily note, without date but with the clip tag if requested
		# URL encode the markdown
		#MD_OUT_ENCODED=`echo "$MD" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'`
	# Decode HTML entities (if present)
	MD_OUT_DECODED=`echo "$MD\n#$CLIP_TAG" | perl -n -mHTML::Entities -e ' ; print HTML::Entities::decode_entities($_) ;'`
	# URL %-encode the markdown
	MD_OUT_ENCODED=`echo "$MD_OUT_DECODED" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'`

	# Send this to NotePlan to create a new note with
	open "noteplan://x-callback-url/addText?noteDate=today&mode=append&text=$MD_OUT_ENCODED&openNote=$OPEN_NOTE&subWindow=$SUB_WINDOW"
fi

# ----
# Test decode string: This &amp; that & them and us &hellip; &para; &ldquo;OK then&rdquo;. What &ndash; to &mdash; do? &deg;&times;&divide;&sdot;&laquo;&raquo
