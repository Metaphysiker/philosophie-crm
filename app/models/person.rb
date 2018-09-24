class Person < ApplicationRecord
  has_paper_trail

  has_many :notes, as: :noteable
  has_many :tasks, as: :taskable

  has_many :affiliations
  has_many :institutions, :through => :affiliations

  validates :email, uniqueness: true

  acts_as_taggable

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

  def self.people_import(file)
    CSV.foreach(file.path, headers: true) do |row|
      create_or_update_person(row.to_hash, row["tag"].split(' | '), nil)
    end
  end

end

private

def create_or_update_person(person, tags, institutions)

  person = person.select!{|x| Person.attribute_names.index(x)}
  unless Person.where(email: person["email"]).nil?
    person = Person.create(person)
  else
    person = Person.where(email: person["email"]).first.update(person)
  end

  unless tags.blank?
    person.tag_list.add(tags)
    person.save
  end

  unless institutions.nil?
    institutions.each do |institution|
      person.institutions << Institution.find(institution)
    end
  end

end
