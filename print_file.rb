def check_file
    filename = ARGV.first # first argument from the command line
    if filename.nil?
      open_file
    else
      if File.exists?(filename) #if file exists
        open_file(filename)
      else
        puts "*** File #{filename} not found ***"
        open_default?
      end
    end
  end
  
  def open_default?
    puts "Do you want to the print the contents of directory.rb ? (y/n)"
    choice = STDIN.gets.chomp.downcase
    if choice == "y"
      open_file
    elsif choice == "n"
      exit
    else
      puts
      puts "*** Option not valid ***"
      puts
      open_default?
    end
  end
  
  def open_file(filename = "directory.rb")
    File.open(filename, "r") do |file|
      file.readlines.each do |line|
        puts line
      end
    file.close
    end
  end
  
  check_file