class CreateUrlTabs < ActiveRecord::Migration
    def self.up
        create_table :url_tabs do |t|
            t.column :project_id, :integer
            t.column :name, :string
            t.column :url, :string
            t.column :css_class, :string
        end
    end

    def self.down
        drop_table :url_tabs
    end
end
