ActionController::Routing::Routes.draw do |map|
  map.connect '/', :controller => 'keys', :action => 'new'
  # who sez only sinatra does iterated routes
  %w(about).each do |route|
    map.connect "/#{route}", :controller => 'site', :action => route
  end
  
  map.connect ':key_url', :controller => 'keys', :action => 'show'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end