  class RolesController < ApplicationController

    before_filter :authenticate_user!, :except => [:index, :show]

  def index
    respond_to do |format|
      format.html { redirect_to(roles_by_index_path) }
      @roles = Role.find(:all, :order => :name)
      format.kml {
        @parent = @roles
        render :template => "colours/index" 
      }
      format.yaml
      format.xml { render :xml => @roles }
      format.json { render :json => @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show

    @role = Role.find_by_slug!(params[:id])
    @related_roles = []  # TODO: add this as an instance method.
    for person in @role.people
      if person # HACK: for some reason, the person is sometimes Nil
        if (@plaques == nil)
          @plaques = person.plaques          
        else
          @plaques = @plaques + person.plaques
        end
      end
    end
    #@centre = find_mean(@plaques)
    @zoom = 7  
    respond_to do |format|
      format.html
      format.kml { render :template => "plaques/show" }
      format.yaml
      format.xml
      format.json { render :json => @role }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find_by_slug(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        flash[:notice] = 'Role was successfully created.'
        format.html { redirect_to(role_path(@role.slug)) }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = Role.find_by_slug(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = 'Role was successfully updated.'
        format.html { redirect_to(role_path(@role.slug)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role = Role.find_by_slug(params[:id])
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
      format.xml  { head :ok }
    end
  end
end
