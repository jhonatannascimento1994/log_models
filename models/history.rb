# == Schema Information
#
# Table name: histories
#
#  id             :integer(4)       not null, primary key
#  parameters     :text(65535)
#  user           :text(65535)
#  reference_id   :integer(4)
#  reference_type :string(255)
#  operation      :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class History < ActiveRecord::Base
  belongs_to :reference, polymorphic: true

  validates :reference_type, :reference_id, presence: true
end