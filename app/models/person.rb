class Person < ApplicationRecord
  has_paper_trail

  has_many :notes, as: :noteable

  validates :email, uniqueness: true

  acts_as_taggable

  def member_of_portal?
    !self.philosophie_id.nil?
  end
end
