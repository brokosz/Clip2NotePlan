#!/bin/bash

# Get the markdown from the HTML from PopClip
MD_OUT=`echo $POPCLIP_HTML | ./html2text.py`

# Default to opening new note, unless the option is set to no
OPEN_NOTE=yes

# FIXME: $POPCLIP_OPTION_OPENNEWNOTE doesn't seem to be filled in from PopClip
# if [ "$POPCLIP_OPTION_OPENNEWNOTE" = "no" ]; then
# $OPEN_NOTE = no
# fi

# FIXME: Same issue filling options for clip date and tag
# if [ ${POPCLIP_OPTION_DATE} = "1" ]; then
# CLIP_DATE=echo -e "date: `date +"%Y-%m-%d %T"`  \n"
# fi
# 
# if [ ${POPCLIP_OPTION_TAG} = "1" ]; then
# CLIP_TAG=echo -e "#clip  \n"
# fi

CLIP_DATE=`date +"%Y-%m-%d %T"`

# Make a little header ... could be extended
if [ ! -z "$POPCLIP_BROWSER_TITLE" ]; then
	#HEADER="# $POPCLIP_BROWSER_TITLE  \nsource: $POPCLIP_BROWSER_URL  \n$CLIP_DATE$CLIP_TAG"
	HEADER="# $POPCLIP_BROWSER_TITLE  \nsource: $POPCLIP_BROWSER_URL  \ndate: $CLIP_DATE  \n#clip  \n"

# else
	# HEADER="\nfrom $POPCLIP_BROWSER_URL\n"
fi

# URL encode the header + markdown
MD_OUT_ENCODED=`echo "$HEADER\n$MD_OUT" | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'`

# Send this to NotePlan to create a new note with
#open "noteplan://x-callback-url/addNote?text=$MD_OUT_ENCODED&openNote=$POPCLIP_OPTION_OPENNEWNOTE"
open "noteplan://x-callback-url/addNote?text=$MD_OUT_ENCODED&openNote=$OPEN_NOTE"
