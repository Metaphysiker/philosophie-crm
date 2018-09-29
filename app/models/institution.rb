class Institution < ApplicationRecord
  after_create :create_address

  has_many :affiliations
  has_many :people, :through => :affiliations

  has_many :notes, as: :noteable
  has_many :tasks, as: :taskable
  has_one :address, as: :addressable

  acts_as_taggable

  scope :search_institutions_ilike, ->(search_term) { where("name ILIKE ?", search_term) }

  include PgSearch
  pg_search_scope :search_institutions, :against => [:name],
                                  :using => {
                                    :tsearch => {:prefix => true, :any_word => true}
                                  }

  pg_search_scope :search_institutions_trigram, :against => [:name],
                                  :using => {
                                    :trigram => {
                                      :threshold => 0.3
                                    },
                                    :tsearch => {
                                      :prefix => true
                                    }
                                  }

  def create_address
    Address.create(
      addressable_id: self.id,
      addressable_type: Institution
    )
  end

end
