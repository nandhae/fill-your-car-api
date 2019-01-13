class PeopleController < ApplicationController
  before_action :authenticate_user!

  def update
    return render_badrequest if User.where(id: params[:id]).empty?

    head :ok if PeopleService.new.save_or_update params[:id], params[:phone]
  end

  def show
    return render_badrequest if Person.where(id: params[:id]).empty?

    render 'people/person.json.jbuilder', locals: { person: Person.where(id: params[:id]).first }, status: :ok

  end
end
