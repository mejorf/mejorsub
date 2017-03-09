## MejorSub

Yet another cmd subtitle downloader, written in Ruby, and using the subdb
api at http://thesubdb.com/api/. It's a single script that allows you to
download subtitles for all videos stored in a given folder. You also can use it to download subs for a single video.


## Running

* Make sure ruby is installed
* run the script:
`./mejorsub.rb -l en -e mp4 "/home/user/myFavoriteShow/"` (this downloads english subtitles for all .mp4 videos in "myFavoriteShow" directory -- replace the directory path for a file path if you only need subs for a single file)
* the output is always directed to same directory as the input and with the same filename.
* `l- --language` and `-e --extension` are optional arguments. If not defined, language defaults to pt and the program looks for the following extensions: avi, mp4, mkv, mpeg, flv, rm, wmv, m4v.
* `-h` for help
