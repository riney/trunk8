class KeysController < ApplicationController
  verify :method => :post, :only => [:create], :redirect_to => { :action => :new_key }
  
  def new_key
    @count = Key.count
  end
  
  def show
    @key = Key.find_by_url(params[:key_url])

    respond_to do |format|
      if @key.nil?
        format.html { redirect_to('/') }
      else
        format.html # show.html.erb
      end
    end
  end

  def create
    @key = Key.new(:license_key => params[:license_key])

    respond_to do |format|
      if @key.save
        flash[:notice] = 'Key was successfully created.'
        format.html { redirect_to("/#{@key.url}") }
      else
        format.html { render :action => "new" }
      end
    end
  end
end