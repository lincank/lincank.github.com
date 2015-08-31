---
layout: post
title: "create zip file on the fly with rubyzip"
date: 2013-04-08 23:13
comments: true
categories: ruby zip
---

I tries to create zip file with multiple files in it, on the fly of course. I refered to [this post](http://info.michael-simons.eu/2008/01/21/using-rubyzip-to-create-zip-files-on-the-fly/), but it does not work for me. I search and try for hours, and figure out one solution.


<!-- more -->

Use `IO.binread` instead of `IO.read`, and it just works! Here is the sample code:

```ruby Zip With Rubyzip On The Fly

	require 'zip/zip'
	require 'zip/zipfilesystem'
 
	t = Tempfile.new("some-weird-temp-file-basename-#{request.remote_ip}")
	# Give the path of the temp file to the zip outputstream, it won't try to open it as an archive.
	Zip::ZipOutputStream.open(t.path) do |zos|
		some_file_list.each do |file|
    		# Create a new entry with some arbitrary name
    		zos.put_next_entry("some-funny-name.jpg")
    		# Add the contents of the file, don't read the stuff linewise if its binary, instead use direct IO
    		# use IO.binread instead of IO.read, and it just works!
    		zos.print IO.binread(file.path)
		end
	end
	# End of the block  automatically closes the file.
	# Send it using the right mime type, with a download window and some nice file name.
	send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "some-brilliant-file-name.zip"
	# The temp file will be deleted some time...
	t.close
	
```