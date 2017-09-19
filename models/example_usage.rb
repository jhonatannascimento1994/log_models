# == Schema Information
#
# Table name: ExampleUsage


class ExampleUsage < ApplicationRecord
  
  has_many :histories, as: :reference
  
end