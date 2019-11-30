class User < ActiveRecord::Base
	has_many :schedules

	def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.save!
    end
  end

	def self.get_admins
		User.where(admin: true).first
	end

	def self.get_non_admins
		User.where(admin: false)
	end

	def schedule_exists? day
		self.schedules.each do |schedule|
			if schedule.start_date == day
				return true
			end
		end
		return false
	end



	# 	User.where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	# 	  user.provider = auth.provider
	# 	  user.uid = auth.uid

	# 	  user.oauth_token = auth.credentials.token
	# 	  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	# 	  user.save
	# 	end
	# end
end
