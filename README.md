# Apartment Management System

A full stack Ruby on Rails web application to be used in managing real property rental businesses. Click [here](https://mwpmi.herokuapp.com) to view the app on Heroku.

#### Test Accounts (Password: `123456`)
- Admin: `admin@test.com`
- Cashier: `cashier1@test.com`
- Receptionist: `receptionist1@test.com`, `receptionist2@test.com`
- Tenant: `tenant1@test.com` (up to `tenant5@test.com`)

## About the Project

### Built With
- [Ruby on Rails](https://rubyonrails.org/)
- [TailwindCSS](https://tailwindcss.com/)

### Features
- Site visitors can send an inquiry form
- Currently has five user roles: Owner, Admin, Cashier, Receptionist, Tenant
- Tenants can pay their dues directly into the app with the help of Paymongo Links
- Tenants can create Concern Tickets
- Receptionist can "reserve" an inquiry. A "reserved" inquiry will not be accessible to other receptionists. This is to determine their performance on handling inquiries
- Receptionist can create a booking for a tenant
- Receptionist can send an email reminder for tenants' incoming dues
- Cashier can create an invoice for a tenant's booking. A PDF can be generated for invoices for downloading and printing purposes
- Cashier can add records of payments of tenants who will be paying in cash
- Cashier can add expense records with uploaded proof
- Owner and Admin can create and lock accounts and post announcements that will be displayed in every user's dashboard

### ERD
![ERD](ERD.png)

### Version
```
* Ruby 3.1.2
* Rails 7.0.4
```

### Setup
```
 $ bundle install
 $ rails db:setup
```
 
### Starting the application
```
 $ rails server
```

### Running the test suite
```
 $ rspec
```

## Roadmap

- [x] Tenant Portal
- [x] Staff Portal
- [x] Paymongo API for Payments
- [x] Printable and Downloadable PDFs for Invoices
- [ ] Notifications
- [ ] Landing Page with Google Map API

For more details about this project's progress, you can visit this [project's sprints](https://github.com/users/jpatrickldg/projects/2).
