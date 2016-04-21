class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]



  # GET /ads
  # GET /ads.json
  def index
     @ads = Ad.paginate(:page => params[:page], :per_page =>5)
#    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/new
  def new
    if logged_in?
      @ad = Ad.new
    else
      redirect_to login_path, :notice => "This page is only avaliable to logged-in users"
  end
 end
  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
        format.json { render :show, status: :created, location: @ad }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    if logged_in?
      respond_to do |format|
        if @ad.update(ad_params)
          format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
          format.json { render :show, status: :ok, location: @ad }
        else
          format.html { render :edit }
          format.json { render json: @ad.errors, status: :unprocessable_entity }
        end
      end
   else
      redirect_to login_path, :notice => "This page is only available to logged-in users"
    end    
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
   if logged_in?
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
     end
    else
    redirect_to login_path, :notice => "This page is only abaliable to logged-in users"
   end
 end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:name, :description, :price, :seller_id, :email, :url_img)
    end

end
