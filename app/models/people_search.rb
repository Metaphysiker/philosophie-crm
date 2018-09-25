class PeopleSearch
  def initialize(search_term: nil, tags: nil, institutions: nil, options: nil, tag_option: "")
    @search_term = search_term
    #@model = model || Person
    @tags = tags
    @institutions = institutions
    @options = options
    @tag_option = tag_option
    @final_results = []
    puts @model.inspect
  end

  def search
    query = Person.all

      unless @tags.nil?
        query = find_people_tagged_with(query, @tags, @tag_option)
      end

      unless @search_term.nil?
        query = query.search_people_ilike(@search_term)
      end

      unless @institutions.nil?
        puts query.inspect
        puts @institutions.pluck(:id).inspect
        query = query.includes(:institutions).where(institutions: {id: @institutions.pluck(:id)})
      end

      query
    end

  end

  def find_people_tagged_with(query, tags, option)

    if option == "match_all"
      query = query.tagged_with(tags, :match_all => true)
    elsif option == "any"
      query = query.tagged_with(tags, :any => true)
    elsif option == "exclude"
      query = query.tagged_with(tags, :exclude => true)
    else
      query = query.tagged_with(tags)
    end

    puts query.inspect
    query
  end
