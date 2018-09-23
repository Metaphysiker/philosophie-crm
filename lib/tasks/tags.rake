namespace :tags do

  task add_tag_to_portal_member: :environment do
    Person.all.each do |person|

      if !person.philosophie_id.nil?
        person.tag_list.add("Portalmitglied")
      else
        person.tag_list.remove("Portalmitglied")
      end
      person.save
    end
  end

end
