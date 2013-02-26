class Item < ActiveRecord::Base
  scope :current, -> { all }

  belongs_to :user
end
