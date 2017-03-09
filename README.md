## MejorSub

Yet another cmd subtitle downloader, written in Ruby, and using the subdb
api at http://thesubdb.com/api/. It's a single script that allows you to
download subtitles for videos in a whole folder or a single file.


## Running

* Make sure ruby is installed
* run the script:
`mejorsub.rb -l en -e mp4 "/home/user/myFavoritShow/"` (this downloads subtitles for all videos in "myFavoritShow" directory)
* the output is always directed to same directory as the input and with the same filename.
* `l- --language` and `-e --extension` are optional arguments. If not defined, language defaults to pt and the program looks for the following extensions: avi, mp4, mkv, mpeg, flv, rm, wmv, m4v.
* `-h` for help
