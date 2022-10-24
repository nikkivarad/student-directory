def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    # create an empty array
    students = []
    # get the first name
    name = gets.chomp
    # while the name is not empty, repeat this code
    while !name.empty? do
      # add the student hash to the array
      students << {name: name, cohort: :november}
      puts "Now we have #{students.count} students"
      # get another name from the user
      name = gets.chomp
    end
    # return the array of students
    students
  end
 
  def print_header
    puts "The students of Villains Academy"
    puts "-------------"
  end
  
 # 8.1 
  def print(students)
    students.each_with_index do |student, index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
  
# 8.2
  def print_by_first_letter(students)
    puts "Student names beginning with: (Please enter a letter)"
    letter = gets.chomp
    number_of_matches = 0
    students.each do |student|
      if student[:name].start_with?(letter.upcase, letter.downcase)
        puts "#{student[:name]} (#{student[:cohort]} cohort)"
        number_of_matches += 1
      else
      end  
    end
    puts
    puts "We have #{number_of_matches} students whose name begins with #{letter}"
    puts
  end
  
# 8.3
  def print_by_name_length(students)
    puts "Names with maximum characters of: (Please enter a number)"
    max_length = gets.chomp
    number_of_matches = 0
    students.each do |student|
      if student[:name].length <= max_length.to_i
        puts "#{student[:name]} (#{student[:cohort]} cohort)"
        number_of_matches += 1
      else
      end  
    end
    puts
    puts "We have #{number_of_matches} students with a name of maximum #{max_length} characters"
    puts
  end

  def print_footer(names)
    puts "Overall, we have #{names.count} great students"
  end

# Call the methods
students = input_students
print_header
print(students)
print_by_name_length(students)
print_footer(students)