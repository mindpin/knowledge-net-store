module KnowledgeNetStore
  class NetsController < KnowledgeNetStore::ApplicationController
    def index
      @nets = KnowledgeNetStore::Net.all
    end

    def show
      @net =  KnowledgeNetStore::Net.find params[:id]
    end

    def new
      @net = KnowledgeNetStore::Net.new
    end

    def create
      @net = KnowledgeNetStore::Net.new net_params
      if @net.save
        redirect_to @net
      else
        render :new
      end
    end

    def edit
      @net = KnowledgeNetStore::Net.find params[:id]
    end

    def update
      @net = KnowledgeNetStore::Net.find params[:id]
      if @net.update_attributes net_params
        redirect_to @net
      else
        render :edit
      end
    end

    def destroy
      @net = KnowledgeNetStore::Net.find(params[:id])
      @net.destroy
      redirect_to nets_path
    end

    private
    def net_params
      params.require(:net).permit(:name, :desc)
    end
  end
end
