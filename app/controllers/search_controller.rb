class SearchController < ApplicationController
  def search
    @people = People.last(20)
  end

  def main_search
    search_inputs = params[:search_inputs]
    puts search_inputs.inspect
    search_term = search_inputs[:search_term]
    tags = search_inputs[:tags]
    institutions = params[:institutions]


    if search_term.nil? || search_term.empty?
      @people = Person.all
    else
      #@people = Person.search_people_trigram(search_term)
      #@people = Person.search_people_ilike("%#{search_term}%")
      @people = PeopleSearch.new(search_term: search_term, tags: tags, institutions: nil, options: nil, tag_option: "").search
    end

    respond_to do |format|
      format.js
    end
  end
end
