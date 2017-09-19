class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # CALLBACKS FOR REGISTER HISTORY
  before_update :clone_preview_state
  after_create  :create_log
  after_update  :check_new_record_for_history

  def history_of_changes_full
    # Option to log full or only diff
    history_of_changes_full = ['ModelWithFullLog']
  end

  def save_user(user)
    @user = user unless user.blank?
  end

  def create_log
    self.histories << History.create(parameters: self.attributes.to_json, user: @user, operation: 'create')
  end

  def delete_log
    self.histories << History.create(parameters: self.deleted_at.to_json, user: @user, operation: 'delete')
  end

  def update_log
    if history_of_changes_full.include? self.class.name
      update = self.attributes
    else
      update = ActivityHistoryHelper.diff_update(self,  @last_current_state)
    end
      self.histories << History.create(parameters: update.to_json, user: @user, operation: 'update') unless update.blank?
  end

  def clone_preview_state
    @last_current_state = self.class.name.constantize.find_by(id: self.id)
  end

  def check_new_record_for_history
    History.where(reference_id: self.id, reference_type: self.class.name).blank? ? create_log : update_log
  end

end
