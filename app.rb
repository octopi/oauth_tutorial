include Mongo

mongo_uri = ENV['MONGOLAB_URI'] || 'mongodb://localhost:27017'

mongo = MongoClient.from_uri(mongo_uri)
db = mongo[mongo_uri[%r{/([^/\?]+)(\?|$)}, 1] || 'test']

get '/' do
	# mongodb usage -- see README for proper db setup
	logger.info(db['testCollection'].find({'foo' => 'meh'}).first)

	erb :index
end

get '/redirect_uri' do
	# TODO STEP 2: get code from Foursquare 

	# TODO STEP 3: make request back to Foursquare

	# TODO STEP 4: get access token from Foursquare

	# get user id for this token
	fsq = Foursquare2::Client.new(:oauth_token => token)
	myself = fsq.user('self')
	fsqId = myself['id']

	# save to db
	db['users'].update({'fsqId' => fsqId}, {'fsqId' => fsqId, 'token' => token}, :upsert => true)

	# redirect to this user's profile page
	redirect '/user/' + fsqId
end

get '/user/:id' do
	user = db['users'].find({'fsqId' => params[:id]}).first

	if user == nil
		erb :notfound
	else
		fsq = Foursquare2::Client.new(:oauth_token => user['token'])
		myself = fsq.user('self')

		# get this user's last location
		venue = myself['checkins']['items'][0]['venue']
		logger.info(venue['name'])

		data = {:user_name => myself['firstName'], :venue_name => venue['name'], :lat => venue['location']['lat'], :lng => venue['location']['lng'], :createdAt => myself['checkins']['items'][0]['createdAt'] }

		erb :where, :locals => data

	end
end

get '/where_test' do
	data = {:user_name => "David", :venue_name=>"The Daily Show with Jon Stewart", :lat=>40.766901289587096, :lng=>-73.99391561038274, :createdAt=>1368476541}

	erb :where, :locals => data
end
