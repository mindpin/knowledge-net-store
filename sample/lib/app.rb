require File.expand_path("../../config/env",__FILE__)

class KnowledgeNetStoreApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :views, ["templates"]
  set :root, File.expand_path("../../", __FILE__)
  register Sinatra::AssetPack
  enable :sessions

  assets {
    serve '/js', :from => 'assets/javascripts'
    serve '/css', :from => 'assets/stylesheets'

    js :application, "/js/application.js", [
      '/js/jquery-1.11.0.min.js',
      '/js/**/*.js'
    ]

    css :application, "/css/application.css", [
      '/css/**/*.css'
    ]

    css_compression :yui
    js_compression  :uglify
  }

  get "/" do
    haml :index
  end

  get "/nets/new" do
    haml :nets_new
  end

  post "/nets" do
    @net = KnowledgeNetStore::Net.new(
      :name => params[:name],
      :desc => params[:desc]
    )
    if @net.save
      return redirect "/"
    end
    redirect "/nets/new"
  end

  get "/nets/:id" do
    @net = KnowledgeNetStore::Net.find(params[:id])
    haml :net_show
  end

  get "/nets/:id/edit" do
    @net = KnowledgeNetStore::Net.find(params[:id])
    haml :net_edit
  end

  post "/nets/:id" do
    @net = KnowledgeNetStore::Net.find(params[:id])
    @net.name = params[:name]
    @net.desc = params[:desc]
    @net.save
    redirect "/nets/#{params[:id]}"
  end

  delete "/nets/:id/destroy" do
    @net = KnowledgeNetStore::Net.find(params[:id])
    @net.destroy
    status 200
  end

end