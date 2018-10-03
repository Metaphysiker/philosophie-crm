class Person < ApplicationRecord
  after_save :set_name
  after_create :create_address

  has_many :notes, as: :noteable
  has_many :tasks, as: :taskable
  has_one :address, as: :addressable

  has_many :affiliations
  has_many :institutions, :through => :affiliations

  validates :email, presence: true
  validates :email, uniqueness: true

  audited

  acts_as_taggable

  scope :search_people_ilike, ->(search_term) { where("firstname ILIKE ? OR lastname ILIKE ? OR email ILIKE ? OR phone ILIKE ? OR login ILIKE ? OR people.name ILIKE ?", search_term, search_term, search_term, search_term, search_term, search_term) }

  include PgSearch

  pg_search_scope :search_people, :against => [:firstname, :lastname, :email, :phone, :login, :name],
                                  :using => {
                                    :tsearch => {:prefix => true, :any_word => true}
                                  }

  pg_search_scope :search_people_institutions,
    :against => [:firstname, :lastname, :email, :phone, :login, :name],
    :associated_against => {
      :institutions => [:name]
    },
    :using => {
      :trigram => {
        :threshold => 0.3
      },
      :tsearch => {
        :any_word => true,
        :prefix => true
      }
    }

  pg_search_scope :search_people_trigram, :against => [:firstname, :lastname, :email, :phone, :login, :name],
                                  :using => {
                                    :trigram => {
                                      :threshold => 0.3
                                    },
                                    :tsearch => {
                                      :any_word => true,
                                      :prefix => true
                                    }
                                  }
  #multisearchable :against => [:firstname, :lastname, :email, :phone, :login]

  def set_name
    name = ""

    if self.firstname.blank? && self.lastname.blank?
      unless self.login.blank?
        name = self.login
      else
        name = self.email
      end
    else
      name = "#{self.firstname} #{self.lastname}"
    end

    self.update_column(:name, name)
    #self.name = "Ferdinand"
  end

  def create_address
    Address.create(
      addressable_id: self.id,
      addressable_type: Person
    )
  end

  def name_legacy
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
    puts person["email"]
    if person["email"].nil? || person["email"].blank?
      return
    elsif Person.where(email: person["email"]).empty?
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
