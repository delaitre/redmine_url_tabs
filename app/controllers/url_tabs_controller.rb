class UrlTabsController < ApplicationController
    unloadable

    before_filter :find_project, :authorize, :only => [ :add, :delete ]

    def add
        error = []
        error << l(:url_tab_setting_error_empty_name) if params[:name].empty?
        error << l(:url_tab_setting_error_invalid_uri) if params[:url].empty?

        if error.empty?
            link = UrlTab.new({ :project_id => @project.id })
            link.name = params[:name]
            link.url = params[:url]
            link.css_class = params[:css_class]
            error << l(:url_tab_setting_error_could_not_add) if !link.save
        end

        if !error.empty?
            error.map! { |s| '<li>' + s + '</li>' }
            flash[:error] = '<ul>' + error.join + '</ul>'
        end

        redirect_to url_for(:controller => 'projects', :action => 'settings', :id => @project.id) + '/url_tabs'
    end

    def delete
        link = UrlTab.find(params[:link_id])
        if link.nil? or !link.destroy
            flash[:error] = l(:url_tab_setting_error_could_not_delete)
        end

        redirect_to url_for(:controller => 'projects', :action => 'settings', :id => @project.id) + '/url_tabs'
    end

    private

    def find_project
        @project = Project.find(params[:project_id])
    end
end

