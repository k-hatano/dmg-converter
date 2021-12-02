on run
	tell application "Finder"
		set fileItem to choose file {ofType:["application/x-apple-diskimage"]}
	end tell
	openFile(fileItem)
end run

on open fileItem
	openFile(fileItem)
end open

on openFile(fileItem)
	set unixPath to POSIX path of fileItem
	activate
	set listResult to choose from list {¬
		"UDRW - UDIF read/write", ¬
		"UDRO - UDIF read only", ¬
		"UCDO - UDIF compressed by ADC", ¬
		"UDZO - UDIF compressed by zlib", ¬
		"UDTO - DVD/CD-R Master", ¬
		"Rdxx - Disk Copy 6.3.3", ¬
		"DC42 - Disk Copy 4.2"}
	set imageFormat to word 1 of item 1 of listResult
	
	set unixCommand to "hdiutil convert " & unixPath & " -format " & imageFormat & " -o " & unixPath & "_" & imageFormat
	try
		set commandResult to (do shell script unixCommand)
		display dialog commandResult buttons {"OK"} default button 1
	on error theError
		display dialog theError buttons {"OK"} default button 1
	end try
	
end openFile