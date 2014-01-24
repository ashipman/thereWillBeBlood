class GlucoseResultsController < ApplicationController

  def new
    #Nothing to do here - just show me the damn form!
  end

  def create
    #Assign a new instance of the "GlucoseResult" class to an @instanceVariable, passing in the relevant attributes.
    @glucose_result = GlucoseResult.new(glucose_result_params)
    #Save the instance (attempt to create a db record, result will determine if we were successful.)
    @glucose_result.save
    #Redirct to the 'show' action.
    redirect_to @glucose_result
  end

  def show
    #Update the @instanceVariable with the item we want to show by finding it in the db using the :id identifier.
    @glucose_result = GlucoseResult.find(params[:id])
  end

  def index
    #Assign all existing results to the @instancevariable.
    @glucose_results = GlucoseResult.all
  end

  def edit
    #Find the item based on the provided :id.
    @glucose_result = GlucoseResult.find(params[:id])
  end

  def update
    #Try to update the record.
    @glucose_result = GlucoseResult.find(params[:id])
    #If the update works, go to the 'show' screen for that record, otherwise re-show this screen (allowing validation
    # messages be shown.)
    if @glucose_result.update(glucose_result_params)
      redirect_to @glucose_result
    else
      render 'edit'
    end
  end

  def destroy
    #Find the item based on the provided :id.
    @glucose_result = GlucoseResult.find(params[:id])
    #Destroy it!!!
    @glucose_result.destroy
    #Redirect the user to an appropriate location.
    redirect_to glucose_results_path
  end

  private
    def glucose_result_params
      #"strong_parameters" requires that we define what parameters we want to accept in the controller.
      params[:in_use] = true
			params.require(:glucose_result).permit(:user_id, :date_time_stamp, :result, :device, :notes, :in_use)
    end
end
