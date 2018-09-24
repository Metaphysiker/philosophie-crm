class Person < ApplicationRecord
  has_paper_trail

  has_many :notes, as: :noteable
  has_many :tasks, as: :taskable

  has_many :affiliations
  has_many :institutions, :through => :affiliations

  validates :email, presence: true
  validates :email, uniqueness: true


  acts_as_taggable

  scope :search_people_ilike, ->(search_term) { where("firstname ILIKE ? OR lastname ILIKE ? OR email ILIKE ? OR phone ILIKE ? OR login ILIKE ?", search_term, search_term, search_term, search_term, search_term) }

  include PgSearch
  pg_search_scope :search_people, :against => [:firstname, :lastname, :email, :phone, :login],
                                  :using => {
                                    :tsearch => {:prefix => true, :any_word => true}
                                  }

  pg_search_scope :search_people_trigram, :against => [:firstname, :lastname, :email, :phone, :login],
                                  :using => {
                                    :trigram => {
                                      :threshold => 0.3
                                    },
                                    :tsearch => {
                                      :prefix => true
                                    }
                                  }
  #multisearchable :against => [:firstname, :lastname, :email, :phone, :login]

  def name
    if self.firstname.blank? && self.lastname.blank?
      unless self.login.blank?
        return self.login
      else
        return self.email
      end
    else
      return "#{self.firstname} #{self.lastname}"
    end
  end

  def member_of_portal?
    !self.philosophie_id.nil?
  end

  def self.create_or_update_person(person, tags, institutions)

    person = person.select!{|x| Person.attribute_names.index(x)}
    if Person.where(email: person["email"]).nil?
      person = Person.create(person)
    else
      Person.find_by_email(person["email"]).update(person)
      person = Person.find_by_email(person["email"])
    end

    unless tags.blank?
      puts tags.inspect
      person.tag_list.add(tags)
      person.save
    end

    unless institutions.nil?
      institutions.each do |institution|
        person.institutions << Institution.find(institution)
      end
    end
  end

end
