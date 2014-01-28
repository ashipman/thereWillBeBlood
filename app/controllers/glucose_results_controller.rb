class GlucoseResultsController < ApplicationController

  def new
    # Initialise a very basic new @glucose_result instance.
		@glucose_result = GlucoseResult.new
  end

  def create
    # Assign a new instance of the "GlucoseResult" class to an @instanceVariable, passing in the relevant attributes.
		@glucose_result = GlucoseResult.new( glucose_result_params )
		@glucose_result.in_use = true
    # Save the instance (attempt to create a db record, result will determine if we were successful.)
    if @glucose_result.save
    	# Redirct to the 'show' action.
    	redirect_to @glucose_result
		else
			render 'new'
		end
  end

  def show
    # Update the @instanceVariable with the item we want to show by finding it in the db using the :id identifier.
    @glucose_result = GlucoseResult.find( params[:id] )
		if @glucose_result.in_use==false
			@glucose_result=nil
		else
			@glucose_result
		end
  end

  def index
    # Assign all existing results (that have the 'in_use' property set to true) to the @instancevariable.
    @glucose_results = GlucoseResult.where( "in_use = 't'" )
  end

  def edit
    # Find the item based on the provided :id.
    @glucose_result = GlucoseResult.find( params[:id] )
  end

  def update
    # Try to update the record.
    @glucose_result = GlucoseResult.find( params[:id] )
    # If the update works, go to the 'show' screen for that record, otherwise re-show this screen (allowing validation
    # messages be shown.)
    if @glucose_result.update( glucose_result_params )
      redirect_to @glucose_result
    else
      render 'edit'
    end
  end

  def destroy
    # Find the item based on the provided :id.
    @glucose_result = GlucoseResult.find( params[:id] )
    # Simulate destroying it by changing the 'in_use' flag.
		@glucose_result.in_use = 0
		@glucose_result.save
		# Destroy it!!!
		# @glucose_result.destroy
    # Redirect the user to an appropriate location.
    redirect_to glucose_results_path
  end

  private
    def glucose_result_params
      # "strong_parameters" requires that we define what parameters we want to accept in the controller.
			params.require( :glucose_result ) .permit( :user_id, :date_time_stamp, :result, :device, :notes )
    end
end
