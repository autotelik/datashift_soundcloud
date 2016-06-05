module DigitalServicesCore
  class Role < ActiveRecord::Base
    self.table_name = "dsc_roles"

    # Users + Roles in own shared DB - external to the main APP
    establish_connection DigitalServicesCore::User.establish_connection_to_users_db_name

    has_and_belongs_to_many :users, join_table: :dsc_users_roles

    belongs_to :resource, polymorphic: true

    validates :resource_type,
              inclusion: { in: Rolify.resource_types },
              allow_nil: true

    scopify
  end
end
