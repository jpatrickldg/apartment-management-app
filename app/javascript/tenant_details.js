let bookingDetails = document.querySelector('.booking-details');
let bookingTable = document.querySelector('.booking-table');

let invoiceDetails = document.querySelector('.invoice-details');
let invoiceTable = document.querySelector('.invoice-table');

let paymentDetails = document.querySelector('.payment-details');
let paymentTable = document.querySelector('.payment-table');

bookingDetails.addEventListener('click', () => {
  bookingDetails.classList.remove('bg-white')
  bookingTable.classList.remove('hidden')
  bookingDetails.classList.add('bg-gray-200')

  invoiceDetails.classList.remove('bg-gray-200')
  invoiceDetails.classList.add('bg-white')
  invoiceTable.classList.add('hidden')

  paymentDetails.classList.remove('bg-gray-200')
  paymentDetails.classList.add('bg-white')
  paymentTable.classList.add('hidden')
})

invoiceDetails.addEventListener('click', () => {
  invoiceDetails.classList.remove('bg-white')
  invoiceTable.classList.remove('hidden')
  invoiceDetails.classList.add('bg-gray-200')

  bookingDetails.classList.remove('bg-gray-200')
  bookingDetails.classList.add('bg-white')
  bookingTable.classList.add('hidden')

  paymentDetails.classList.remove('bg-gray-200')
  paymentDetails.classList.add('bg-white')
  paymentTable.classList.add('hidden')
})

paymentDetails.addEventListener('click', () => {
  paymentDetails.classList.remove('bg-white')
  paymentTable.classList.remove('hidden')
  paymentDetails.classList.add('bg-gray-200')

  invoiceDetails.classList.remove('bg-gray-200')
  invoiceDetails.classList.add('bg-white')
  invoiceTable.classList.add('hidden')

  bookingDetails.classList.remove('bg-gray-200')
  bookingDetails.classList.add('bg-white')
  bookingTable.classList.add('hidden')
})