# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Payment.destroy_all 
Invoice.destroy_all 
Booking.destroy_all 
Inquiry.destroy_all
Concern.destroy_all
Expense.destroy_all
Announcement.destroy_all
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
    contact_no: '09123456789',
    address: 'Trial Address 1',
    role: 'admin',
    occupation: 'admin',
    confirmed_at: Time.now
  },
  {
    email: 'owner@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'owner',
    last_name: 'owner',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '09213456789',
    address: 'Trial Address 2',
    role: 'owner',
    occupation: 'owner',
    confirmed_at: Time.now
  },
  {
    email: 'receptionist1@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'receptionist1',
    last_name: 'receptionist1',
    birthdate: Date.today,
    gender: 'female',
    contact_no: '09432123213',
    address: 'Trial Address 3',
    role: 'receptionist',
    occupation: 'staff',
    confirmed_at: Time.now
  },
  {
    email: 'receptionist2@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'receptionist2',
    last_name: 'receptionist2',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '09432123211',
    address: 'Trial Address 4',
    role: 'receptionist',
    occupation: 'staff',
    confirmed_at: Time.now
  },
  {
    email: 'cashier1@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'cashier1',
    last_name: 'cashier1',
    birthdate: Date.today,
    gender: 'female',
    contact_no: '09432123242',
    address: 'Trial Address 5',
    role: 'cashier',
    occupation: 'staff',
    confirmed_at: Time.now
  },
  {
    email: 'cashier2@test.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'cashier2',
    last_name: 'cashier2',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '09432123457',
    address: 'Trial Address 6',
    role: 'cashier',
    occupation: 'staff',
    confirmed_at: Time.now
  }
])

5.times do |x|
  User.create({
    email: "tenant#{x+1}@test.com",
    password: '123456',
    password_confirmation: '123456',
    first_name: "Tenant#{x+1}",
    last_name: "Test#{x+1}",
    birthdate: Date.today,
    gender: 'male',
    contact_no: "0912345678#{x}",
    address: "Trial Address #{x+6}",
    role: 'tenant',
    occupation: 'student',
    emergency_contact_person: "Parent#{x}",
    emergency_contact_no: "0912545678#{x}",
    confirmed_at: Time.now
  })
end

Branch.create([
  {
    branch_type: 'Boarding House',
    address: 'Recto Avenue, Sampaloc, Manila'
  },
  {
    branch_type: 'Condominium - Fully Furnished',
    address: 'Espana Boulevard, Manila'
  },
  {
    branch_type: 'Bedspace',
    address: 'Vicente Cruz St., Sampaloc, Manila'
  },
  {
    branch_type: 'Condominium - Empty',
    address: 'Tacio St., Sampaloc, Manila'
  },
  {
    branch_type: 'Studio',
    address: 'Maria Cristina St., Sampaloc, Manila'
  },
  {
    branch_type: 'Bedspace',
    address: 'Cristobal St., Sampaloc, Manila'
  },
])