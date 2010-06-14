require 'dispatcher'
require_dependency 'lib/redmine/menu_manager'

module UrlTabMenuManagerPatch
    def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
            alias_method_chain :render_menu, :url_tab_items
        end
    end

    module InstanceMethods
        def render_menu_with_url_tab_items(menu, project=nil)
            links = []
            menu_items_for(menu, project) do |node|
                links << render_menu_node(node, project)
            end

            if menu == :project_menu and !project.nil?
                tabs = UrlTab.find(:all, :conditions => { :project_id => project.id })
                tabs.each { |tab|
                    links << content_tag(:li, link_to(h(tab.name), tab.url, :class => tab.css_class))
                }
            end
            links.empty? ? nil : content_tag(:ul, links.join("\n"))
        end
    end
end

Dispatcher.to_prepare do
    Redmine::MenuManager::MenuHelper::send(:include, UrlTabMenuManagerPatch)
end

