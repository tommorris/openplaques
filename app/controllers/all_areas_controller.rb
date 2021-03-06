class AllAreasController < ApplicationController
  
  respond_to :json
  
  def index
    if params[:term]
      @areas = Area.all(:conditions => ["lower(name) LIKE ?", params[:term].downcase + "%"], :limit => 10, :order => "locations_count DESC", :include => :country)
    else
      @areas = Area.all
    end
    respond_with @areas
  end
  # [{"label": "test", "value": "1"}]
  
end
