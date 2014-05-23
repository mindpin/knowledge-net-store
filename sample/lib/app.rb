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
    haml :net_new
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

  get "/nets/:net_id/points/new" do
    @net = KnowledgeNetStore::Net.find(params[:net_id])
    haml :point_new
  end

  post "/nets/:net_id/points" do
    @net = KnowledgeNetStore::Net.find(params[:net_id])
    @point = @net.points.build
    @point.name = params[:name]
    @point.desc = params[:desc]
    @point.parent_ids = params[:parent_ids]
    @point.save
    redirect "/nets/#{params[:net_id]}"
  end

  get "/nets/:net_id/points/:id" do
    @net = KnowledgeNetStore::Net.find(params[:net_id])
    @point = @net.points.find(params[:id])
    haml :point_show
  end

  get "/nets/:net_id/points/:id/edit" do
    @net = KnowledgeNetStore::Net.find(params[:net_id])
    @point = @net.points.find(params[:id])
    haml :point_edit
  end  

  post "/nets/:net_id/points/:id" do
    @net = KnowledgeNetStore::Net.find(params[:net_id])
    @point = @net.points.find(params[:id])
    @point.name = params[:name]
    @point.desc = params[:desc]
    @point.parent_ids = params[:parent_ids]
    @point.save
    redirect "/nets/#{params[:net_id]}/points/#{@point.id}"
  end

  delete "/points/:id/destroy" do
    @point = KnowledgeNetStore::Point.find(params[:id])
    @point.destroy
    status 200
  end

end