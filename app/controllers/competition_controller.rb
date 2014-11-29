
class CompetitionController < ApplicationController

  def entry
    @title = "Competition"
    @id = id
  end

  def submit
    @title = "Well done"
    @kata = params[:KataID]
  end

private

end
