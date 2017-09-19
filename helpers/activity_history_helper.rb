module ActivityHistoryHelper

  IGNORED_ATTRIBUTES = [ 'created_at', 'updated_at', 'deleted_at' ]

  def self.diff_update(new_object, old_object)
    diff = Hash.new
    old_object.attributes.each do |key, value|
      unless IGNORED_ATTRIBUTES.include? key
        diff[key] = { "old".to_sym => value, "new".to_sym => new_object[key] } unless new_object[key] == value
      end
    end
    diff
  end

end
