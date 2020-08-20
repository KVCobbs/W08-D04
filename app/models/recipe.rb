class Recipe < ApplicationRecord
  #this is the model association
  belongs_to :category


  #this is the validations
  validates_presence_of :name
end
