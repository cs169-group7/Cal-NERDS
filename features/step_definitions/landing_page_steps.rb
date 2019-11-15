Given /^the following users exist:$/ do |users_table|
	users_table.hashes.each do |user|
		User.create(user)
	end
end

Given /^I am logged in as (\w+)$/ do |name|
	user = User.where(name: name)[0]
	OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
		:provider => "google_oauth2",
		:uid => "12345",
		:info => OmniAuth::AuthHash::InfoHash.new({
			:name => user.name,
			:email => user.email
	 	})
	})
	visit "/"
	# debugger
	click_link "Log In with Google"
end
