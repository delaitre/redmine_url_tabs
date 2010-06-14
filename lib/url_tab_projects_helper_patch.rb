require 'dispatcher'
require_dependency 'projects_helper'

module UrlTabProjectsHelperPatch
    def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
            alias_method_chain :project_settings_tabs, :url_tab_tab
        end
    end

    module InstanceMethods
        def project_settings_tabs_with_url_tab_tab
            tabs = project_settings_tabs_without_url_tab_tab
            tab = { :name => 'url_tabs', :action => :manage_url_tab, :partial => 'projects/settings/url_tab', :label => :url_tab_project_settings_tab }
            tabs << tab if User.current.allowed_to?(tab[:action], @project)
            return tabs
        end
    end
end

Dispatcher.to_prepare do
    ProjectsHelper::send(:include, UrlTabProjectsHelperPatch)
end

