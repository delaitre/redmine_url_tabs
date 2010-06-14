class UrlTab < ActiveRecord::Base
    belongs_to :project

    validates_presence_of :project_id

    def initialize(arguments = nil)
        super(arguments)
    end
end

