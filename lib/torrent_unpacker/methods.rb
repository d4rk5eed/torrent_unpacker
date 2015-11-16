def extract_movie(source, dest, start_item)
  sorted = Dir[source + '*'].sort do |a, b|
    a[/S\d{2}E\d{2}/] <=> b[/S\d{2}E\d{2}/]
  end

  last_index = sorted.index do |item|
    item =~ /#{start_item}/
  end

  cutted = sorted.slice(last_index + 1, sorted.length)

  cutted.each do |dir|
    archive = Dir[dir + '/*.rar'].sort.first

    if archive
      system "unrar e -y #{archive} '#{dest}' > /dev/null"
      archive[/S\d{2}E\d{2}/]
    end
  end
end
