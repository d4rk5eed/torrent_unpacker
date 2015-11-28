def extract_movie(source, dest, start_item)
  dirs_list = Dir[source + '*']
  if dirs_list.empty?
    puts "Incorrect source dir #{source}\n"
    return []
  end

  sorted = dirs_list.sort do |a, b|
    a[/S\d{2}E\d{2}/] <=> b[/S\d{2}E\d{2}/]
  end

  last_index = sorted.index do |item|
    item =~ /#{start_item}/
  end

  if last_index.nil?
    puts "Incorrect start item #{start_item} in #{source}\n"
    return []
  end

  cutted = sorted.slice(last_index + 1, sorted.length)

  cutted.each do |dir|
    archive = Dir[dir + '/*.rar'].sort.first

    if archive
      print "Unpacking '#{archive}' to '#{dest}'\n"
      system "unrar e -y #{archive} '#{dest}'"
      archive[/S\d{2}E\d{2}/]
    end
  end
end
