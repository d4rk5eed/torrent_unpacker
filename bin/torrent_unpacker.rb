#!/usr/bin/env ruby

require_relative File.expand_path(File.dirname(__FILE__) + '/../lib/torrent_unpacker')

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: torrent_unpacker.rb [options]"

  opts.on("-c CONFIG_FILE", "--config=CONFIG_FILE", "Config file location") do |v|
    options[:config] = File.expand_path(v)
  end
  opts.on("-d DATABASE_FILE", "--database=DATABASE_FILE", "SQLite database file location") do |v|
    options[:database] = File.expand_path(v)
  end
end.parse!

database_file = options[:database] || 'db/torrents.db'
DB = Sequel.connect("jdbc:sqlite:/#{database_file}")

DB.create_table :torrents do
  String :torrent
  String :last_item
  unique :torrent
end unless DB.table_exists?(:torrents)

config = YAML.load_file(options[:config])

config.each do |k, v|
  current = DB[:torrents][torrent: k]

  start_item = current ? current[:last_item] : v['start_item']
  last_item = extract_movie(v['source'], v['dest'], start_item).last

  if last_item
    if current
      DB[:torrents].update(torrent: k, last_item: last_item[/S\d{2}E\d{2}/])
    else
      DB[:torrents].insert(torrent: k, last_item: last_item[/S\d{2}E\d{2}/])
    end
  end
end
