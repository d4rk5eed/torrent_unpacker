# torrent_unpacker
##About
This application assigned to extract downloaded torrents on synology to predefined directory

##Usage
`bundle install`

1. Create db directory (for example ~/.torrent_unpacker/database.sql)
2. Create config (for example ~/.torrents_unpacker/config.yml)
3. Fill the config with torrents info:

  ```
  the_big_bang_theory:
          source: '/home/torrents/The.Big.Bang.Theory'
          dest: '/var/videos/the big bang theory'
          start_item: 'S01E01'
  walking_dead:
          source: '/home/torrents/Walking.Dead'
          dest: '/var/videos/walking dead'
  ```
start_item param specifies episode which unpacking will start from.
4. Execute app with `lib/torrents_unpacker.rb -d ~/.torrent_unpacker/database.sql -c ~/.torrents_unpacker/config.yml`

## TODO
1. Make an executable
2. Make command line params `-c <config> -d <database>`
3. Make initial episode as config param
