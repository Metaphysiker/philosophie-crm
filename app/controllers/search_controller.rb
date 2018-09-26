class SearchController < ApplicationController
  def search
    @people = Person.last(20)
  end

  def main_search
    search_inputs = params[:search_inputs]

    search_term = search_inputs[:search_term]
    tags = search_inputs[:tags]
    institutions = search_inputs[:institutions]


      #@people = Person.search_people_trigram(search_term)
      #@people = Person.search_people_ilike("%#{search_term}%")
    @people = PeopleSearch.new(search_term: search_term, tags: tags, institutions: institutions, options: nil, tag_option: "").search


    #@people = PeopleSearch.new(institutions: institutions).search

    respond_to do |format|
      format.js
    end
  end
end
