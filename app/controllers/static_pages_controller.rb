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

  def search
    @people = Person.includes(:notes).last(20)
  end

  def activities
    @audits = Audited::Audit.last(1)
    #@versions = PaperTrail::Version.order(:created_at => :desc).limit(20)
  end
end
