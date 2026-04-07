class My::TimezonesController < ApplicationController
  def update
    Current.user.settings.update!(timezone_name: timezone_param)

    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end

  private
    def timezone_param
      params[:timezone_name]
    end
end
