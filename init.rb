require 'redmine'

require 'url_tab_menu_manager_patch'
require 'url_tab_projects_helper_patch'

Redmine::Plugin.register :redmine_url_tab do
    name 'Redmine Url Tabs plugin'
    author 'Jérémie Delaitre'
    description 'This is a plugin to add per-project tabs associated to custom urls'
    version '0.0.1'

    project_module :url_tab do
        permission :manage_url_tab, :url_tabs => [ :add, :delete ]
    end
end

