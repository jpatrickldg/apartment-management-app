// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import "@fortawesome/fontawesome-free"

import "chartkick"
import "Chart.bundle"

let btn = document.querySelector('.mobile-menu-button');
let sidebar = document.querySelector('aside');

btn.addEventListener('click', () => {
  sidebar.classList.toggle('-translate-x-full')
  btn.classList.toggle('bg-gray-300')
})