class Institution < ApplicationRecord
  has_many :affiliations
  has_many :people, :through => :affiliations
end
