class Admin::AccessoriesController < Admin::BaseController
  def index
    @accessories = Accessory.all
  end

  # private
  #
  # def accessories_params
  #   params.require(:accessories).permit()
  # end
end
