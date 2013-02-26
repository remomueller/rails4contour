class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @order = scrub_order(Item, params[:order], "items.name")
    @items = Item.current.order(@order).page(params[:page]).per( 20 )
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.current.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params[:item] ||= {}

      [:bought_date].each do |date|
        params[:item][date] = parse_date(params[:item][date])
      end

      params.require(:item).permit(:name, :description, :user_id, :bought_date)
    end

    # Scrub order and parse_date can be moved to your ApplicationController
    def scrub_order(model, params_order, default_order)
      (params_column, params_direction) = params_order.to_s.strip.downcase.split(' ')
      direction = (params_direction == 'desc' ? 'DESC' : nil)
      column_name = (model.column_names.collect{|c| model.table_name + "." + c}.select{|c| c == params_column}.first)
      order = column_name.blank? ? default_order : [column_name, direction].compact.join(' ')
      order
    end

    def parse_date(date_string, default_date = '')
      date_string.to_s.split('/').last.size == 2 ? Date.strptime(date_string, "%m/%d/%y") : Date.strptime(date_string, "%m/%d/%Y") rescue default_date
    end
end


# class ItemsController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_item, only: [:show, :edit, :update, :destroy]

#   # GET /items
#   # GET /items.json
#   def index
#     @items = Item.all
#   end

#   # GET /items/1
#   # GET /items/1.json
#   def show
#   end

#   # GET /items/new
#   def new
#     @item = Item.new
#   end

#   # GET /items/1/edit
#   def edit
#   end

#   # POST /items
#   # POST /items.json
#   def create
#     @item = Item.new(item_params)

#     respond_to do |format|
#       if @item.save
#         format.html { redirect_to @item, notice: 'Item was successfully created.' }
#         format.json { render action: 'show', status: :created, location: @item }
#       else
#         format.html { render action: 'new' }
#         format.json { render json: @item.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /items/1
#   # PATCH/PUT /items/1.json
#   def update
#     respond_to do |format|
#       if @item.update(item_params)
#         format.html { redirect_to @item, notice: 'Item was successfully updated.' }
#         format.json { head :no_content }
#       else
#         format.html { render action: 'edit' }
#         format.json { render json: @item.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /items/1
#   # DELETE /items/1.json
#   def destroy
#     @item.destroy
#     respond_to do |format|
#       format.html { redirect_to items_url }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_item
#       @item = Item.find(params[:id])
#     end

#     # Never trust parameters from the scary internet, only allow the white list through.
#     def item_params
#       params.require(:item).permit(:name, :description, :user_id, :bought_date)
#     end
# end
