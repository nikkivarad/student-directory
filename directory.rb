# 8.7
@students = [] # an empty array accessible to all methods

@cohorts = {
  January: 15,
  February: 25,
  March: 25,
  April: 20,
  May: 10,
  June: 25,
  July: 25,
  August: 15,
  September: 0,
  October: 0,
  November: 0,
  December: 8
}

#helpers
def pluralize_students(n)
  if n == 1 then "#{n} great student" else "#{n} great students" end
end

@width = 50

def divider
  puts "-------------".center(@width)
end

@loaded_filename = ""
@default_filename = "students.csv"

def header_menu
  divider
  puts "-- Student Directory".center(@width)
  puts "-- Using file: #{@loaded_filename}".center(@width)
  divider
end

def interactive_main_menu
    loop do
      print_main_menu
      process_main_menu(STDIN.gets.chomp)
    end
end

def interactive_search_menu
    loop do
      print_search_menu
      process_search_menu(STDIN.gets.chomp)
    end
end

def print_main_menu
  header_menu
  puts
  puts "*** MAIN MENU"
  puts  "1.  Input students"
  puts  "2.  Show students"
  puts  "3.  Search students"
  puts  "4.  Save the list to file"
  puts  "5.  Load the list from file"
  puts  "9.  Exit" 
  puts
end

def print_search_menu
    puts
    puts "Student Search:"
    puts "1. Search by First Letter"
    puts "2. Search by Name Length"
    puts "3. Back to Main Menu"
    puts
end
  
def process_search_menu(selection)
    case selection
    when "1"
      search_by_first_letter
    when "2"
      search_by_name_length
    when "3"
      interactive_main_menu
    else
      puts "I don't know what you meant, please try again"
    end
end

def process_main_menu(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    interactive_search_menu
  when "4"
    puts  "Please enter the name of the file (eg. data.csv)"
    save_filename = gets.chomp
    save_filename.empty? ? save_students : save_students(save_filename)
  when "5"
    puts  "Please enter the name of the file (eg. data.csv)" 
    puts  "or leave empty to open the default file"
    load_filename = gets.chomp
    load_filename.empty? ? load_students : load_students(load_filename)
  when "9"
    exit #this will cause the program to terminate
  else
    puts "I don't know what you meant, please try again"
  end
end

def show_students
    print_header
    print_students_list
    print_footer
end

def create_new_student
    puts "Do you want to create a new student? (y/n)".center(@width)
    continue = STDIN.gets.chomp.downcase
    if continue == "y"
      return true
    elsif continue == "n"
      return false
    else
      puts "Invalid choice - please enter y or n".center(@width)
    end
    create_new_student
  end

def add_cohort
  next_cohort = :December
  puts
  puts "Available cohorts:".center(@width)
  puts "(Month / Vacancies)".center(@width)
  month_number = 1
  @cohorts.each do |month, vacancies|
    puts "(#{month_number}) #{month} - vacancies: #{vacancies}".center(@width)
    month_number +=1
  end
  puts
  puts "Please enter the month number of the cohort would like to join".center(@width)
  cohort = STDIN.gets.chomp
  case cohort
  when "1"
    cohort = :January
  when "2"
    cohort = :February
  when "3"
    cohort = :March
  when "4"
    cohort = :April
  when "5"
    cohort = :May
  when "6"
    cohort = :June
  when "7"
    cohort = :July
  when "8"
    cohort = :August
  when "9"
    cohort = :December
  when "10"
    cohort = :December
  when "11"
    cohort = :December
  when "12"
    cohort = :December
  when ""
    puts "No input, the upcoming #{next_cohort} cohort will be added".center(@width)
    cohort = next_cohort
  else
    puts "Input not recognised, the upcoming #{next_cohort} cohort was added".center(@width)
  end
  cohort
end
  
def input_students
    continue = create_new_student
    while continue
      puts "Please enter the name of the student".center(@width)
      name = STDIN.gets.chomp
      puts "Please enter the cohort".center(@width)
      cohort = add_cohort
      puts "Please enter the country of birth".center(@width)
      country_of_birth = STDIN.gets.chomp
      hobbies = add_hobbies
      add_student(name, cohort, country_of_birth, hobbies)
      puts "Now we have #{pluralize_students @students.count}".center(@width)      
      continue = create_new_student
    end
  end
  
  def add_hobbies
    hobbies = []
    puts "Please enter student's hobbies".center(@width)
    puts "(To finish, just hit return twice)".center(@width)
    hobby = STDIN.gets.chomp
    while !hobby.empty?
      hobbies << hobby
      hobby = STDIN.gets.chomp
    end
    hobbies.join(" ")
  end

  def add_student(name, cohort, country_of_birth, hobbies)
    @students << {name: name, cohort: cohort.to_sym, country_of_birth: country_of_birth, hobbies: hobbies}
  end

  def save_students(filename = @default_filename)
    # open the file for writing
    file = File.open(filename, "w") do |file|
    # iterate over the array of students
      @students.each do |student|
        student_data = [student[:name], student[:cohort], student[:country_of_birth], student[:hobbies]]
        csv_line = student_data.join(",")
        file.puts csv_line
      end
      puts
      puts  "*** Saved successfully to #{filename} ***"
      puts
    end
  end
  
  def load_students(filename = @default_filename)
    file = File.open(filename, "r") do |file|
      file.readlines.each do |line|
      name, cohort, country_of_birth, hobbies = line.chomp.split(',')
      add_student(name, cohort, country_of_birth, hobbies)
      end
      puts
      puts  "*** File loaded successfully ***"
      puts  "*** Using: #{filename}"
      puts
    end
  end

  def try_load_students
    filename = ARGV.first     # first argument from the command line
    if filename.nil?
        puts
        puts "Loaded the default file: #{@default_filename}"
        puts
        @loaded_filename = @default_filename
        load_students
    elsif File.exists?(filename) # if it exists
      @loaded_filename = filename
      load_students(filename)
    else      # if it doesn't exist
      puts "Sorry, #{filename} not found."
      exit    # quit the program
    end
  end

  def print_header
    if !@students.empty?
        puts "The students of Villains Academy".center(@width)
        divider
    else
    end
  end
  
def print_students_list
  if @students.empty?
        puts "No students available".center(@width)
      else
        i = 0
        while i < @students.count
          puts "#{i + 1}. #{@students[i][:name]}, #{@students[i][:country_of_birth]} (#{@students[i][:cohort]})".center(@width)
          i += 1
        end
    end
  end
  
  def print_students_list_by_cohort
    if @students.empty?
      puts "No students available".center(@width)
    else
      cohorts = @students.map do |student|
        student[:cohort]
      end
      cohorts.uniq.each do |cohort|
        puts "#{cohort} cohort".upcase.center(@width)
          @students.each do |student|
            puts student[:name] if student[:cohort] == cohort
          end
      end
    end
  end

# OPTIONAL - Clean code and fix problem with puts statements in search methods
  def search_by_first_letter
    if @students.empty?
        puts "No students available".center(@width)
    else
        puts "Student names beginning with: (Please enter a letter)".center(@width)
        letter = gets.strip
        number_of_matches = 0
        @students.each do |student|
          if student[:name].start_with?(letter.upcase, letter.downcase)
          puts "#{student[:name]}, #{student[:country_of_birth]} (#{student[:cohort]} cohort)".center(@width)
            number_of_matches += 1
          else
          end  
        end
        puts
        puts "We have #{pluralize_students number_of_matches} whose name begins with #{letter}".center(@width)
        puts
      end
    end

  def search_by_name_length
    if @students.empty?
        puts "No students available".center(@width)
      else
        puts "Names with maximum characters of: (Please enter a number)".center(@width)
        max_length = gets.strip
        number_of_matches = 0
        @students.each do |student|
          if student[:name].length <= max_length.to_i
            puts "#{student[:name]}, #{student[:country_of_birth]} (#{student[:cohort]} cohort)".center(@width)
            number_of_matches += 1
          else
          end  
        end
        puts
        puts "We have #{pluralize_students number_of_matches} with a name of maximum #{max_length} characters".center(@width)
        puts
    end
end

  def print_footer
    if !@students.empty?
      puts "Overall, we have #{pluralize_students @students.count}".center(@width)      
    else
    end
  end

#call the interactive menu
try_load_students
interactive_main_menu