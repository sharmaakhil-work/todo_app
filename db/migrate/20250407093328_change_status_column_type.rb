class ChangeStatusColumnType < ActiveRecord::Migration[7.0]
  def up
    # First ensure we have a status column of the right type
    # Remove the column if it exists but is the wrong type
    if column_exists?(:todos, :status) && !column_for_attribute(:todos, :status).type == :string
      remove_column :todos, :status
    end
    
    # Add the column if it doesn't exist
    unless column_exists?(:todos, :status)
      add_column :todos, :status, :string, default: "not_started"
    end
    
    # Update existing records
    execute <<-SQL
      UPDATE todos
      SET status = CASE 
                     WHEN completed = true THEN 'completed'
                     ELSE 'not_started'
                   END
      WHERE status IS NULL
    SQL
  end
  
  def down
    # No need to remove the column in the down migration
  end
  
  private
  
  def column_for_attribute(table, attribute)
    connection.columns(table).find { |c| c.name == attribute.to_s }
  end
end