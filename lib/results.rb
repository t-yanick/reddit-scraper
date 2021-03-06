class Results
  attr_accessor :file

  def initialize(arr)
    prefix = './remote_jobs/job_listing_for_'
    @file = File.open(prefix + "#{arr[0]}.html", 'w+')
  end

  def begin_html
    File.open('./html/begin.txt').each do |line|
      @file.puts line
    end
  end

  def store(title_arr, company_arr, location_arr, url_arr)
    h3 = '<h3></h3>'
    h4 = '<h4></h4>'
    line = '.............................................'
    (0..title_arr.length).each do |x|
      @file.puts "#{h3}#{title_arr[x]}#{h4}#{company_arr[x]}#{h4}#{location_arr[x]}#{h4}#{url_arr[x]}#{h4}#{line[x]}"
    end
  end

  def end_html
    File.open('./html/end.txt').each do |line|
      @file.puts line
    end
  end

  def close_file
    @file.close
  end
end
