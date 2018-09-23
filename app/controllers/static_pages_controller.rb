class StaticPagesController < ApplicationController
  def welcome
  end

  def main
    @people = Person.all.includes(:notes)
    @notes = Note.all.order(:created_at).reverse_order
    @tag_lists = TagList.all
    @tasks = Task.all
  end
end
