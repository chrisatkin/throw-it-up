# require 'compass'
require 'sinatra'
require 'haml'

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, "views"
set :public, 'static'

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