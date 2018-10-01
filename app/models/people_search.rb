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

    unless @search_term.nil? || @search_term.blank?
      query = query.search_people_ilike("%#{@search_term}%")
      #query = query.search_people_trigram(@search_term)
    end

    unless @institutions.nil? || @institutions.empty?
      institutions = @institutions.reject { |c| c.blank? }
      institutions = institutions.collect {|x| x.to_i}
      unless institutions.empty?
        query = query.includes(:institutions).where(institutions: {id: institutions})
      end
    end

      unless @tags.nil? || @tags.empty?
        tags = @tags.reject { |c| c.blank? }
        unless tags.empty?
          query = find_people_tagged_with(query, tags, @tag_option)
        end
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
