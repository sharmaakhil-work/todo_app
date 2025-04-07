class Todo < ApplicationRecord
  validates :title, presence: true
  
  # Explicitly declare the status attribute type
  attribute :status, :string
  
  # Priority options
  enum priority: {
    low: "low",
    medium: "medium",
    high: "high"
  }
  
  # Status options - with explicit string mapping
  enum status: {
    not_started: "not_started",
    in_progress: "in_progress",
    completed: "completed"
  }
  
  # Set default status for new records
  after_initialize :set_default_status, if: :new_record?
  
  def set_default_status
    self.status ||= "not_started" 
  end
  
  # Default scope to order by creation date
  default_scope { order(created_at: :desc) }
  
  # Scope to find by status
  scope :not_started_todos, -> { where(status: "not_started") }
  scope :in_progress_todos, -> { where(status: "in_progress") }
  scope :completed_todos, -> { where(status: "completed") }
  
  # Helper method to check if completed
  def completed?
    status == "completed"
  end
  
  # Helper method to check if in progress
  def in_progress?
    status == "in_progress"
  end
  
  # Helper method to check if not started
  def not_started?
    status == "not_started"
  end
end