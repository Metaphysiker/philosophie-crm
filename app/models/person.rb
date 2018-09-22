class Person < ApplicationRecord
  has_paper_trail

  has_many :notes, as: :noteable

  validates :email, uniqueness: true

  acts_as_taggable

  include PgSearch
  pg_search_scope :search_people, :against => [:firstname, :lastname, :email, :phone, :login],
                                  :using => {
                                    :tsearch => {:prefix => true}
                                  }
  #multisearchable :against => [:firstname, :lastname, :email, :phone, :login]

  def member_of_portal?
    !self.philosophie_id.nil?
  end
end
