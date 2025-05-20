class ShopsController < ApplicationController
    # Disabling authenticity token for testing, otherwise sends 422 error code if send POST via curl. Remove this once deployed!
    # General advice: if you're only handling API requests in this controller, not too bad to remove "only", but massive security issues if not
    skip_before_action :verify_authenticity_token
    # skip_before_action :verify_authenticity_token, only: [:create]

    def index
        # Returns a simple HTML page listing all available shops
        @shops = Shop.all
        unless @shops.blank?
            # @site = cookies[:current_username]
            respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @site }
            end else
                render status: :not_found
            end
    end

    def show
        #New function that loads a specific site, returns not found if not found
        shop_id = params[:id]

        @shop = Shop.find_by(identifier: shop_id)

        unless @shop.blank?
            #if @site.visit_count > 0
            #    @average_time = (@site.total_time_spent.to_f / @site.visit_count).round(4)
            #else
            #    @average_time = 0
            #end

            respond_to do |format|
            format.html { render :show } # Would need show.html.erb
            format.json { render json: {shop: @shop, average_time: @average_time}, status: :ok } # And need to render this average_time calc value
        end
        else
            head :not_found
        end
    end

    def create
        #Create function posts out specific site and registers new visit
        shop_id = params[:id]

        @shop = Shop.find_or_create_by(identifier: shop_id) do |site|
            #site.visit_count = 0
            #site.total_time_spent = 0
        end
        
        #@shop.increment!(:visit_count) # Increments and saves in one step
        
        respond_to do |format|
            format.html { redirect_to shops_path, notice: "Shop created." } #shops_path redirects to GET /shops route
            format.json { render json: @shop, status: :ok }
        end
    end
end