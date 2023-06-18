# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Payment.destroy_all 
# Invoice.destroy_all 
# Booking.destroy_all 
# Inquiry.destroy_all
# Concern.destroy_all
# Expense.destroy_all
# Announcement.destroy_all
# User.destroy_all


User.create([
  {
    email: 'suamwpmi@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'admin',
    last_name: 'admin',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '09087731123',
    address: 'Sampaloc, Manila',
    role: 'admin',
    occupation: 'admin',
    confirmed_at: Time.now
  },
  {
    email: 'ownermwpmi@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'owner',
    last_name: 'owner',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '09223392811',
    address: 'Sampaloc, Manila',
    role: 'owner',
    occupation: 'owner',
    confirmed_at: Time.now
  },
  {
    email: 'recmwpmi@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'receptionist',
    last_name: 'staff',
    birthdate: Date.today,
    gender: 'female',
    contact_no: '09432123213',
    address: 'Sampaloc, Manila',
    role: 'receptionist',
    occupation: 'staff',
    confirmed_at: Time.now
  },
  {
    email: 'cashiermwpmi@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    first_name: 'cashier',
    last_name: 'staff',
    birthdate: Date.today,
    gender: 'male',
    contact_no: '09432123457',
    address: 'Sampaloc, Manila',
    role: 'cashier',
    occupation: 'staff',
    confirmed_at: Time.now
  }
])

# 5.times do |x|
#   User.create({
#     email: "tenant#{x+1}@gmail.com",
#     password: '123456',
#     password_confirmation: '123456',
#     first_name: "Tenant#{x+1}",
#     last_name: "Test#{x+1}",
#     birthdate: Date.today,
#     gender: 'male',
#     contact_no: "0912345678#{x}",
#     address: "Trial Address #{x+6}",
#     role: 'tenant',
#     occupation: 'student',
#     emergency_contact_person: "Parent#{x}",
#     emergency_contact_no: "0912545678#{x}",
#     confirmed_at: Time.now
#   })
# end

branches = [
  {
    branch_type: 'Boarding House',
    address: 'Recto Avenue, Sampaloc, Manila',
    rooms: [
      { 
        room_code: 'B1R1',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B1R2',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B1R3',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B1R4',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B1R5',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
    ]
  },
  {
    branch_type: 'Condominium - Fully Furnished',
    address: 'Espana Boulevard, Manila',
    rooms: [
      { 
        room_code: 'B2R1',
        monthly_rate: 12000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
      { 
        room_code: 'B2R2',
        monthly_rate: 12000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
      { 
        room_code: 'B2R3',
        monthly_rate: 12000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
    ]
  },
  {
    branch_type: 'Bedspace',
    address: 'Vicente Cruz St., Sampaloc, Manila',
    rooms: [
      { 
        room_code: 'B3R1',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B3R2',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B3R3',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B3R4',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B3R5',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
    ]
  },
  {
    branch_type: 'Condominium - Empty',
    address: 'Tacio St., Sampaloc, Manila',
    rooms: [
      { 
        room_code: 'B4R1',
        monthly_rate: 10000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
      { 
        room_code: 'B4R2',
        monthly_rate: 10000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
      { 
        room_code: 'B4R3',
        monthly_rate: 10000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
    ]
  },
  {
    branch_type: 'Studio',
    address: 'Maria Cristina St., Sampaloc, Manila',
    rooms: [
      { 
        room_code: 'B5R1',
        monthly_rate: 8000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
      { 
        room_code: 'B5R2',
        monthly_rate: 8000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
      { 
        room_code: 'B5R3',
        monthly_rate: 8000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
      { 
        room_code: 'B5R4',
        monthly_rate: 8000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
      { 
        room_code: 'B5R5',
        monthly_rate: 8000, 
        occupants_count: 0,
        capacity_count: 1, 
      },
    ]
  },
  {
    branch_type: 'Bedspace',
    address: 'Cristobal St., Sampaloc, Manila',
    rooms: [
      { 
        room_code: 'B6R1',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B6R2',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B6R3',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B6R4',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
      { 
        room_code: 'B6R5',
        monthly_rate: 5000, 
        occupants_count: 0,
        capacity_count: 8, 
      },
    ]
  }
]

branches.each do |branch_attrs|
  branch = Branch.create(branch_attrs.except(:rooms))
  branch_attrs[:rooms].each do |room_attrs|
    branch.rooms.create(room_attrs)
  end
end