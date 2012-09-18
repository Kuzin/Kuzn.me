require 'rubygems'
require 'sinatra'
require 'rdiscount'
require 'xml-sitemap'
require 'slim'

# Partial Helper
module Sinatra
  module RenderPartial
    def partial(page)
      slim page
    end
  end
  helpers RenderPartial
end

# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :public_folder, 'public'
set :markdown, :layout_engine => :slim

# Set Slim Options
Slim::Engine.set_default_options :pretty => true

# Application routes
get '/' do
    slim :index, :layout => :'layouts/application'
end

get '/cv' do
  slim :resume, :layout => :'layouts/application'
end

get '/about' do
  slim :about, :layout => :'layouts/application'
end


# Sitemap
get '/sitemap.xml' do
    map = XmlSitemap::Map.new('kuzn.me') do |m|
        m.add(:url => '/', :period => :weekly)
        m.add(:url => '/about', :period => :weekly)
    end
    headers['Content-Type'] = 'text/xml'
    map.render
end


