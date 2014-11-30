
class CompetitionController < ApplicationController

  def entry
    @title = "Competition"
    @id = id
  end

  def submit
    @title = "Thanks for entering! | Bluefruit Google Glass Competition"
    @fullname = params[:fullname]
    @email = params[:email]
    @kata = params[:KataID]
    @publish = params[:publish]
    @career = params[:career]
    @news = params[:news]
    @age = params[:age]
    @ip = request.remote_ip;

    dojo.competition.create_entry(@kata, @fullname, @email, @publish, @career, @news, @age, @ip)
  end

private

end
