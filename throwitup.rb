# require 'compass'
require 'sinatra'
require 'haml'
require 'twitter'

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, "views"
set :public, 'static'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "YOUR_CONSUMER_KEY"
  config.consumer_secret     = "YOUR_CONSUMER_SECRET"
  config.access_token        = "YOUR_ACCESS_TOKEN"
  config.access_token_secret = "YOUR_ACCESS_SECRET"
end

configure do
  set :haml, {:format => :html5, :escape_html => false}
  # set :sass, {:style => :compact, :debug_info => false}
  # Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.rb'))
end

# get '/stylesheets/:name.css' do
#   content_type 'text/css', :charset => 'utf-8'
#   scss(:"static/stylesheets/#{params[:name]}" )
# end

get '/' do
  haml :index
end

get '/view' do
  haml :view
end

get '/search/:hashtag' do
  json hashtag: params[:hashtag]
end