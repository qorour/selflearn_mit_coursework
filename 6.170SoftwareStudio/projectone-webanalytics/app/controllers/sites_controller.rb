class SitesController < ApplicationController
    # Disabling authenticity token for testing, otherwise sends 422 error code if send POST via curl. Remove this once deployed!
    skip_before_action :verify_authenticity_token, only: [:create]

    def index
        # Index function returns a simple HTML page listing the identifier numbers of visited sites and the number of visits to each site.
        @sites = Site.all
        unless @sites.blank?
            # @site = cookies[:current_username]
            respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @site }
            end else
                render status: :not_found
            end
    end

    def new
        #New function looks for specific site and creates if not yet made
        site_id = params[:id]

        @site = Site.find_by(identifier: site_id)

        unless @site.blank?
            respond_to do |format|
            format.html { render :show } # Would need show.html.erb
            format.json { render json: @site, status: :ok }
        end
        else
            head :not_found
        end
    end

    def create
        #Create function posts out specific site and registers new visit
        site_id = params[:id]

        @site = Site.find_or_create_by(identifier: site_id) do |site|
            site.visit_count = 0
        end
        
        @site.increment!(:visit_count) # Increments and saves in one step
        
        respond_to do |format|
            format.html { redirect_to sites_path, notice: "Visit registered." }
            format.json { render json: @site, status: :ok }
        end
    end
end
