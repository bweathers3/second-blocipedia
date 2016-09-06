class WikisController < ApplicationController


  def index
     @wikis = policy_scope(Wiki)
   end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki, :show?
  end

  def new
     @wiki = Wiki.new
     #authorize @wiki, :create?
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki, :update?
  end

  def create

     @wiki = Wiki.new(wiki_params)
     @wiki.user = current_user
     #authorize @wiki, :create?

     if @wiki.save
       flash[:notice] = "Your Wiki was saved successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
     end
   end

   def update

      @wiki = Wiki.find(params[:id])
      @wiki.assign_attributes(wiki_params)
      authorize @wiki, :update?

      if @wiki.save
        flash[:notice] = "Your Wiki was updated successfully."
        redirect_to wikis_path
      else
        flash.now[:alert] = "There was an error saving the wiki. Please try again."
        render :edit
      end
    end

  def destroy

     @wiki = Wiki.find(params[:id])
     authorize @wiki, :destroy?

     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
   end

private

 def wiki_params
   params.require(:wiki).permit(:title, :body, :private)
 end


end
