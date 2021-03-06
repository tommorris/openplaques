class PeopleController < ApplicationController
  
  
  before_filter :authorisation_required, :except => [:index, :show]
  
  def index
    @people = Person.find(:all)
    respond_to do |format|
      format.html { redirect_to(:controller => :people_by_index, :action => "show", :id => "a") }
      format.kml {
        @parent = @people
        render :template => "colours/index" 
      }
      format.yaml
      format.xml { render :xml => @people }
      format.json { render :json => @people }
    end
    
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])
    @plaques = @person.plaques
#    @centre = find_mean(@plaques)
    @zoom = 12
    respond_to do |format|
      format.html
      format.kml { render :template => "plaques/show" }
      format.yaml
      format.xml  { render :xml => @person }
      format.json { render :json => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
    @roles = Role.all(:order => :name)
    @personal_role = PersonalRole.new
    @died_on = @person.died_on.year if @person.died_on
    @born_on = @person.born_on.year if @person.born_on
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])

    if params[:born_on].blank?
      @person.born_on = nil
    else
      @person.born_on = Date.parse(params[:born_on] + "-01-01")
    end

    if params[:died_on].blank?
      @person.died_on = nil
    else
      @person.died_on = Date.parse(params[:died_on] + "-01-01")
    end

    respond_to do |format|
      if @person.save
        flash[:notice] = 'Person was successfully created.'
        format.html { redirect_to(@person) }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else        
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])
    
    if params[:born_on].blank?
      @person.born_on = nil
    else
      @person.born_on = Date.parse(params[:born_on] + "-01-01")
    end

    if params[:died_on].blank?
      @person.died_on = nil
    else
      @person.died_on = Date.parse(params[:died_on] + "-01-01")
    end

    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:notice] = 'Person was successfully updated.'
        format.html { redirect_to(@person) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end
end
