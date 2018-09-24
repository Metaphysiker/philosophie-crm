class ImportController < ApplicationController
  def upload_page

  end

  def institution

  end

  def people
    Person.people_import(params[:file])
    redirect_to upload_page_path, notice: "CSV importiert!"
  end
end
