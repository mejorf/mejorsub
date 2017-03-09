#!/usr/bin/env ruby

require 'net/http'
require 'digest'

# Generates an object that downloads subtitles from subdb
class SubDownloader
  def initialize(ext, directory, language = 'pt')
    @directory = directory
    if File.directory?(@directory)
      @ext = ext
      @language = language
      @files = listfiles
      @files_and_hashes = gen_hashes
      downloadall
    elsif File.file?(@directory)
      download(@directory)
    else
      abort('Argument must be a file or a directory path')
    end
  end

  # translate the python function given by thesubdb api to get the hash of a
  # file
  def get_hash(name)
    readsize = 64 * 1024
    File.open(name, 'rb') do |f|
      # size = File.size?(name) #useless line from the api
      data = f.read(readsize)
      f.seek(-readsize, IO::SEEK_END)
      data += f.read(readsize)
      Digest::MD5.hexdigest(data)
    end
  end

  # generate an array of files in a directory
  def listfiles
    if @directory[-1] != '/'
      Dir[@directory + '/*' + @ext]
    else
      Dir[@directory + '*' + @ext]
    end
  end

  # takes a file array and returns an array of hashes
  def gen_hashes
    hashes = []
    @files.each do |file|
      hashes << get_hash(file)
    end
    # make a dict with filenames as keys and hashes as values
    # (we need the filenames to save the srt files later)
    Hash[@files.zip hashes]
  end

  # downloads from individual hashes
  def download(hash)
    header = { 'User-Agent' => 'SubDB/1.0 (MejorSub /1.0;
        https://github.com/mejorf/mejorsub)' }
    http = Net::HTTP.new 'api.thesubdb.com'
    begin
      download = http.send_request('GET', '/?action=download&hash=' + hash +
                                   "&language=#{@language}", nil, header)
      out = @files_and_hashes.key(hash).gsub(/\.[^.]*$/, '.srt')
      File.open(out, 'wb') { |f| f.write(download.body) }
      puts out + ' sucessfully downloaded'
    rescue Exception => e
      puts e
    end
  end

  def downloadall
    puts @files_and_hashes
    @files_and_hashes.each do |_filename, hash|
      download hash
    end
  end
end

SubDownloader.new ARGV[0], ARGV[1], ARGV[2]
