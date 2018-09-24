class ImportController < ApplicationController
  def upload_page

  end

  def institution

  end

  def people
    Person.people_import(params[:file])
    redirect_to root_url, notice: "CSV importiert!"
  end
end
