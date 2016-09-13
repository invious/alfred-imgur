on run
	-- Function to check if JSON Helper is installed
	set jsonHelperExists to false
	try
		do shell script "osascript -e 'exists application \"JSON Helper\"'"
		set jsonHelperExists to true
	end try

	-- Abort if not installed
	if jsonHelperExists is false then
		return "Couldn't find JSON Helper. Install via http://www.appstore.com/mac/jsonhelperforapplescript"
	end if

	-- Check if API key file exists
	try
		do shell script "/bin/ls ~/.alfred-imgur.conf"
	on error errMsg number errNum
		return "Couldn't find Imgur API key (~/.alfred-imgur.conf)."
	end try

	-- Find selected file
	tell application "Finder"
		set someSource to selection as alias list
		if someSource = {} then
			return "Select a file in Finder first"
		end if
		set theFile to item 1 of someSource as alias
		set theFileInfo to info for theFile
		set theName to name of theFileInfo
		set theExt to name extension of theFileInfo
	end tell

	-- List of allowed file types
	set ImgTypes to {"JPEG", "JPG", "PNG", "GIF", "APNG", "TIFF", "BMP", "PDF", "XCF"}

	-- Abort if not listed
	if theExt is not in ImgTypes then
		return "A file with an extention " & theExt & " can't be uploaded"
	end if

	-- Call upload function and return the link
	set sUpload to imgur(theFile, false)
	set the clipboard to sUpload
	return sUpload
end run

-- Imgur upload function using OAuth (API v3)
on imgur(_Image, _isOpen)
	set sImg to (POSIX path of _Image)
	set apikey to do shell script "/bin/cat ~/.alfred-imgur.conf"

	set curlCommand to "curl -H \"Authorization: Client-ID " & apikey & "\" -F \"image=@" & sImg & "\" https://api.imgur.com/3/upload"
	set answer to do shell script curlCommand

	tell application "JSON Helper"
		set jsonAPI to read JSON from answer
		set link to link of |data| of jsonAPI
	end tell

	if _isOpen = true then
		tell application "Finder" to open location link
	end if
	return link
end imgur
