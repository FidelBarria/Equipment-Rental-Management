// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const dropdownElementList = document.querySelectorAll('.dropdown-toggle')
  dropdownElementList.forEach((dropdownToggleEl) => {
    new bootstrap.Dropdown(dropdownToggleEl)
  })
})