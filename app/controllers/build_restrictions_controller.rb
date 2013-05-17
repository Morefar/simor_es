class BuildRestrictionsController < ApplicationController
  # GET /build_restrictions
  # GET /build_restrictions.json
  def index
    @build_restrictions = BuildRestriction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @build_restrictions }
    end
  end

  # GET /build_restrictions/1
  # GET /build_restrictions/1.json
  def show
    @build_restriction = BuildRestriction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @build_restriction }
    end
  end

  # GET /build_restrictions/new
  # GET /build_restrictions/new.json
  def new
    @build_restriction = BuildRestriction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @build_restriction }
    end
  end

  # GET /build_restrictions/1/edit
  def edit
    @build_restriction = BuildRestriction.find(params[:id])
  end

  # POST /build_restrictions
  # POST /build_restrictions.json
  def create
    @build_restriction = BuildRestriction.new(params[:build_restriction])

    respond_to do |format|
      if @build_restriction.save
        format.html { redirect_to @build_restriction, notice: 'Build restriction was successfully created.' }
        format.json { render json: @build_restriction, status: :created, location: @build_restriction }
      else
        format.html { render action: "new" }
        format.json { render json: @build_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /build_restrictions/1
  # PUT /build_restrictions/1.json
  def update
    @build_restriction = BuildRestriction.find(params[:id])

    respond_to do |format|
      if @build_restriction.update_attributes(params[:build_restriction])
        format.html { redirect_to @build_restriction, notice: 'Build restriction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @build_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /build_restrictions/1
  # DELETE /build_restrictions/1.json
  def destroy
    @build_restriction = BuildRestriction.find(params[:id])
    @build_restriction.destroy

    respond_to do |format|
      format.html { redirect_to build_restrictions_url }
      format.json { head :no_content }
    end
  end
end
