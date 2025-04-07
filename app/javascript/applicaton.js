// Configure your import map in config/importmap.rb

import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', () => {
  // Initialize tooltips
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })
  
  // Handle priority selection coloring
  const prioritySelect = document.querySelector('select[name="todo[priority]"]')
  if (prioritySelect) {
    prioritySelect.addEventListener('change', function() {
      this.classList.remove('text-danger', 'text-warning', 'text-info')
      
      switch(this.value) {
        case 'high':
          this.classList.add('text-danger')
          break
        case 'medium':
          this.classList.add('text-warning')
          break
        case 'low':
          this.classList.add('text-info')
          break
      }
    })
  }
  
  // Handle filter buttons
  const filterButtons = document.querySelectorAll('.filter-todos')
  filterButtons.forEach(button => {
    button.addEventListener('click', function() {
      const filter = this.dataset.filter
      const todos = document.querySelectorAll('.list-group-item')
      
      filterButtons.forEach(btn => btn.classList.remove('active'))
      this.classList.add('active')
      
      todos.forEach(todo => {
        if (filter === 'all') {
          todo.style.display = 'flex'
        } else if (filter === 'completed' && todo.classList.contains('list-group-item-success')) {
          todo.style.display = 'flex'
        } else if (filter === 'incomplete' && !todo.classList.contains('list-group-item-success')) {
          todo.style.display = 'flex'
        } else {
          todo.style.display = 'none'
        }
      })
    })
  })
})