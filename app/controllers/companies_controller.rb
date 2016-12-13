class CompaniesController < ApplicationController
	def index
		@companies = Company.all
	end

	def show
		@company = Company.find(params[:id])
	end

	def new
	end

	def create
		company = Company.create(
				:name => params[:name], 
     		:slogan => params[:slogan], 
      	:phone => params[:phone]
			)
  	redirect_to "/companies/#{company.id}"
	end

	def edit
		@company = Company.find(params[:id])
	end
	def update
	 	company = Company.find(params[:id])	
	 	company.update(
				:name => params[:name], 
	      	:slogan => params[:slogan], 
	      	:phone => params[:phone]
				)
  	redirect_to "/companies/#{company.id}"
  end
	def destroy
		company = Company.find(params[:id])
		company.destroy
		redirect_to "/companies"
	end
end
