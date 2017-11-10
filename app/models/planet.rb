class Planet < ApplicationRecord
  validates_presence_of :name, case_sensitive: false
end
