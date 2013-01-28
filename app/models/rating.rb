class Rating < ActiveRecord::Base
  attr_accessible :movie, :number, :user

  belongs_to :movie
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :movie
  validates_numericality_of :number
  validates_inclusion_of :number, in: 0..5
end
