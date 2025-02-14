class SitesController < ApplicationController
    # Disabling authenticity token for testing, otherwise sends 422 error code if send POST via curl. Remove this once deployed!
    # General advice: if you're only handling API requests in this controller, not too bad to remove "only", but massive security issues if not
    skip_before_action :verify_authenticity_token
    # skip_before_action :verify_authenticity_token, only: [:create]

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
        #New function finds specific site and returns error if not found
        site_id = params[:id]

        @site = Site.find_by(identifier: site_id)

        unless @site.blank?
            if @site.visit_count > 0
                @average_time = (@site.total_time_spent.to_f / @site.visit_count).round(4)
            else
                @average_time = 0
            end

            respond_to do |format|
            format.html { render :show } # Would need show.html.erb
            format.json { render json: {site: @site, average_time: @average_time}, status: :ok } # And need to render this average_time calc value
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
            site.total_time_spent = 0
        end
        
        @site.increment!(:visit_count) # Increments and saves in one step
        
        respond_to do |format|
            format.html { redirect_to sites_path, notice: "Visit registered." }
            format.json { render json: @site, status: :ok }
        end
    end

    def update
        #Create function posts out specific site and registers new visit
        site_id = params[:id]

        @site = Site.find_by(identifier: site_id)

        unless @site.blank?
            # don't need to return specific response format so don't need "respond_to do |format|"
            @site.visit_count += 1
            @site.total_time_spent ||= 0 #if not defined yet, set to 0
            @site.total_time_spent += params[:duration].to_i #add total time, can use to calc average time on page
            @site.save
        else
            head :not_found
        end
    end
end
