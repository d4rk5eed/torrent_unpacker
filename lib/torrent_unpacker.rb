require 'yaml'
require 'sequel'
require_relative 'torrent_unpacker/methods'

LAST = 'S09E06'
# ARGV[0]: config file path
DB = Sequel.connect('sqlite://db/torrents.db')

DB.create_table :torrents do
  String :torrent
  String :last_item
  unique :torrent
end unless DB.table_exists?(:torrents)

file_name = File.expand_path(ARGV[0])
config = YAML.load_file(file_name)

config.each do |k, v|
  current = DB[:torrents][torrent: k]

  #print "Last: #{current}\n"
  #print "Last: #{current[:torrent]}\n"
  #print "Last: #{current[:last_item]}\n"

  last_item = extract_movie(v['source'], v['dest'], current[:last_item]).last

  if last_item
    DB[:torrents].update(torrent: k, last_item: last_item[/S\d{2}E\d{2}/])
    #print "Last item #{last_item[/S\d{2}E\d{2}/]}\n"
  end
end
