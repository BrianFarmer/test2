# app/controllers/cow_controller.rb
class CowController < ApplicationController
  def say
	puts params[:message]
    @message = Cow.new.say(params[:message])
  end
end