class DestroyColumnAttendees < ActiveRecord::Migration[5.2]
  def change
  	remove_column :attendees, :ticket_id
  end
end
