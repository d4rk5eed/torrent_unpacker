# torrent_unpacker
##About
This application assigned to extract downloaded torrents on synology to predefined directory

##Usage
1. Create db directory
2. Create config (for example ~/.torrents_unpacker/config.yml)
3. Fill the config with torrents info:

  ```
  the_big_bang_theory:
          source: '/home/torrents/The.Big.Bang.Theory'
          dest: '/var/videos/the big bang theory'
  walking_dead:
          source: '/home/torrents/Walking.Dead'
          dest: '/var/videos/walking dead'
  ```

4. Execute app with `torrents_unpacker ~/.torrents_unpacker/config.yml`
