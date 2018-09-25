class Search
  def initialize(search_term: nil, model: nil, tags: nil, options: nil, tags_option: "")
    @search_term = search_term
    @model = model || Person
    @tags = tags
    @options = options
    @tags_option = tags_option
    @final_results = []
    puts @model.inspect
  end

  def search
    query = @model.all

    unless @search_term.nil?
      query
    end

    unless @tags.nil?
      query = find_objects_tagged_with(query, @tags, @tags_option)
    end

    #models_with_tags = [Person, Institution]
    #["Lehrperson", "Portalmitglied"]
    puts query.inspect
    query
  end

  def find_objects_tagged_with(query, tags, option)

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

end
