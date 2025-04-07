# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# This file creates initial data for development and testing

puts "Cleaning database..."
Todo.destroy_all

puts "Creating sample todos..."

todos = [
  {
    title: "Complete Rails Todo App",
    description: "Build a functional todo application with Rails and Bootstrap",
    completed: false,
    due_date: Date.today + 3.days,
    priority: "high"
  },
  {
    title: "Learn React.js",
    description: "Complete React.js beginner tutorials and build a simple application",
    completed: false,
    due_date: Date.today + 7.days,
    priority: "medium"
  },
  {
    title: "Buy groceries",
    description: "Milk, eggs, bread, vegetables",
    completed: true,
    due_date: Date.today - 1.day,
    priority: "low"
  },
  {
    title: "Read 'Clean Code' book",
    description: "Complete at least chapters 1-3 for software development best practices",
    completed: false,
    due_date: Date.today + 14.days,
    priority: "medium"
  },
  {
    title: "Schedule dentist appointment",
    description: "Call Dr. Smith's office for annual checkup",
    completed: false,
    due_date: Date.today + 10.days,
    priority: "low"
  }
]

todos.each do |todo|
  Todo.create!(todo)
  puts "Created todo: #{todo[:title]}"
end

puts "Created #{Todo.count} todos"