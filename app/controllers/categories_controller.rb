class CategoriesController < AdminController
  before_action :load_user

  def index
    @categories = @user.Category.find_by id: params[:id]
  end
end
