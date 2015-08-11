class RemovingRecipientsFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :recipient_id
  end
end
