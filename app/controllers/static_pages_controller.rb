class StaticPagesController < ApplicationController
  def welcome
  end

  def main
    @people = Person.includes(:notes).last(20) #Person.all.includes(:notes)
    @notes = Note.all.order(:created_at).reverse_order
    @tag_lists = TagList.all
    @tasks = Task.all
    @institutions = Institution.all
  end
end
