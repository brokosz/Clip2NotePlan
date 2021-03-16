#!/bin/bash

# From PopClip get the markdown from the TEXT
MD=`echo $POPCLIP_TEXT`

# Default to not opening new note, unless the option is set to yes
OPEN_NOTE="no"
if [ "$POPCLIP_OPTION_OPENNOTE" == "1" ]; then
	OPEN_NOTE="yes"
fi

# Default to not opening new note in new window, unless the option is set to yes
SUB_WINDOW="no"
if [ "$POPCLIP_OPTION_SUBWINDOW" == "1" ]; then
	SUB_WINDOW="yes"
fi

# Include source if it's asked for in options
CLIP_SOURCE=""
if [ "$POPCLIP_OPTION_ADDSOURCE" == "1" ]; then
	CLIP_SOURCE=`echo "source: $POPCLIP_APP_NAME"`
fi

# Get clip tag to append if it's asked for in options
CLIP_TAG=""
if [ ! -z "$POPCLIP_OPTION_ADDTAG" ]; then
	CLIP_TAG=`echo "#$POPCLIP_OPTION_ADDTAG"`
fi

# FYI, POPCLIP_MODIFIER_FLAGS of 1048576 = ⌘ pressed

# If no modifier key was pressed, then create a new note
if [[ "$POPCLIP_MODIFIER_FLAGS" -eq 0 ]]; then
	
	# Decode HTML entities (if present)
	MD_OUT_DECODED=`echo "$MD\n---\n$CLIP_SOURCE\n$CLIP_TAG\n---" | perl -n -mHTML::Entities -e ' ; print HTML::Entities::decode_entities($_) ;'`
	# URL %-encode the markdown
	MD_OUT_ENCODED=`echo "$MD_OUT_DECODED" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'`


	# Send this to NotePlan to create a new note with
	open "noteplan://x-callback-url/addNote?text=$MD_OUT_ENCODED&openNote=$OPEN_NOTE&subWindow=$SUB_WINDOW"


else
	
	# Decode HTML entities (if present)
	MD_OUT_DECODED=`echo "$MD\n$CLIP_SOURCE\n$CLIP_TAG" | perl -n -mHTML::Entities -e ' ; print HTML::Entities::decode_entities($_) ;'`
	# URL %-encode the markdown
	MD_OUT_ENCODED=`echo "$MD_OUT_DECODED" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'`

	# Send this to NotePlan to create a new note with
	open "noteplan://x-callback-url/addText?noteDate=today&mode=append&text=$MD_OUT_ENCODED&openNote=$OPEN_NOTE&subWindow=$SUB_WINDOW"
fi

# ----
# Test decode string: This &amp; that & them and us &hellip; &para; &ldquo;OK then&rdquo;. What &ndash; to &mdash; do? &deg;&times;&divide;&sdot;&laquo;&raquo
