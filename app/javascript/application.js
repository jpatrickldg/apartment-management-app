// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import "@fortawesome/fontawesome-free"

import "chartkick"
import "Chart.bundle"

let menu = document.querySelector('.menu');
let sidebar = document.querySelector('aside');

menu.addEventListener('click', () => {
  sidebar.classList.toggle('-left-64')
  sidebar.classList.toggle('transition-all')
  sidebar.classList.toggle('duration-100')
})