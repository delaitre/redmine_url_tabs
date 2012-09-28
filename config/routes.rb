ActionController::Routing::Routes.draw do |map|
	  map.connect 'projects/:id/url_tabs/:action', :controller => 'url_tabs'
end
