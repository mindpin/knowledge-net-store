module KnowledgeNetStore
  class PointsController < KnowledgeNetStore::ApplicationController
    before_action :set_net
    def index
      @points = @net.points
    end

    def show
      @point =  @net.points.find params[:id]
    end

    def new
      @point = @net.points.new
    end

    def create
      @point = @net.points.new point_params
      if @point.save
        redirect_to [@net, @point]
      else
        render :new
      end
    end

    def edit
      @point = @net.points.find params[:id]
    end

    def update
      @point = @net.points.find params[:id]
      if @point.update_attributes point_params
        redirect_to [@net, @point]
      else
        render :edit
      end
    end

    def destroy
      @point = KnowledgeNetStore::Point.find(params[:id])
      @point.destroy
      redirect_to root_path
    end

    private
    def set_net
      @net = KnowledgeNetStore::Net.find params[:net_id]
    end

    def point_params
      params.require(:point).permit(:name, :desc, parent_ids: [])
    end
  end
end

