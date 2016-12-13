class Company
	attr_accessor :name, :slogan, :phone, :id
	def initialize(input_hash)
		@id = input_hash[:id]
		@name = input_hash[:name]
		@slogan = input_hash[:slogan]
		@phone = input_hash[:phone]
	end	

	def self.all
		companies_hash_array = Unirest.get("http://localhost:3001/companies",headers:{
				"Accept" => "application/json",
				"Authorization" => "Token token=#{ENV['USER_API_KEY']}",
				"X-User-Email" => "#{ENV['EMAIL']}" 
			}
		).body
		companies = []
		companies_hash_array.each do |company_hash|
			companies << Company.new(
				id: company_hash["id"],
				name: company_hash["name"],
				slogan: company_hash["slogan"],
				phone: company_hash["phone"]
				)
		end
		return companies
	end

	def self.find(input_id)
		company_hash = Unirest.get("http://localhost:3001/companies/#{input_id}",headers:{
				"Accept" => "application/json",
				"Authorization" => "Token token=#{ENV['USER_API_KEY']}",
				"X-User-Email" => "#{ENV['EMAIL']}" 
			}).body

		company = Company.new(
			id: company_hash["id"],
			name: company_hash["name"],
			slogan: company_hash["slogan"],
			phone: company_hash["phone"]
			)
		return company
	end

	def self.create(parameters)
		company_hash = Unirest.post(
			"http://localhost:3001/companies",headers:{
				"Accept" => "application/json",
				"Authorization" => "Token token=#{ENV['USER_API_KEY']}",
				"X-User-Email" => "#{ENV['EMAIL']}" 
			}, 
      parameters:{ 
      	:name => parameters[:name], 
      	:slogan => parameters[:slogan], 
      	:phone => parameters[:phone] 
      	}
    	).body
		company = Company.new(
			id: company_hash["id"],
			name: company_hash["name"],
			slogan: company_hash["slogan"],
			phone: company_hash["phone"]
			)
		return company
	end

	def update(parameters)
		company_hash = Unirest.patch(
			"http://localhost:3001/companies/#{id}",
			headers:{
				"Accept" => "application/json",
				"Authorization" => "Token token=#{ENV['USER_API_KEY']}",
				"X-User-Email" => "#{ENV['EMAIL']}" 
			}, 
      parameters:{ 
      	:name => parameters[:name], 
      	:slogan => parameters[:slogan], 
      	:phone => parameters[:phone] 
      	}
    	).body
		#notice how here I can do company_hash instead of repeating lines 47-50
		company = Company.new(company_hash)
		return company
	end
	def destroy
		Unirest.delete("http://localhost:3001/companies/#{id}",headers:{
				"Accept" => "application/json",
				"Authorization" => "Token token=#{ENV['USER_API_KEY']}",
				"X-User-Email" => "#{ENV['EMAIL']}" 
			})
	end
end