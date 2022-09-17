# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all

User.create([
  {
    email: 'admin@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'admin',
    last_name: 'admin',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '123456',
    address: 'qc',
    role: 'admin',
    occupation: 'admin'
  },
  {
    email: 'receptionist@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'receptionist',
    last_name: 'receptionist',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '123456',
    address: 'qc',
    role: 'receptionist',
    occupation: 'staff'
  },
  {
    email: 'cashier@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'cashier',
    last_name: 'cashier',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '123456',
    address: 'qc',
    role: 'cashier',
    occupation: 'staff'
  },
  {
    email: 'owner@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'owner',
    last_name: 'owner',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '123456',
    address: 'qc',
    role: 'owner',
    occupation: 'staff'
  },
  {
    email: 'maintenance@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'maintenance',
    last_name: 'maintenance',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '123456',
    address: 'qc',
    role: 'maintenance',
    occupation: 'staff'
  }
])

10.times do |x|
  User.create({
    email: "tenant#{x}@test.com",
    password: '123456',
    password_confirmation: '123456',
    first_name: "tenant#{x}",
    last_name: "tenant#{x}",
    birthdate: Date.today,
    gender: 'male',
    contact_no: '123456',
    address: 'qc',
    role: 'tenant',
    occupation: 'student'
  })
end