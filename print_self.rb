def print_file
    file = File.open($0, "r")
      file.readlines.each do |line|
        puts line
      end
    file.close
  end
  
  print_file
  
  # This can also be used to get the name of the currently executed file puts File.basename(__FILE__)