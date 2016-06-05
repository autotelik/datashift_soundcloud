  class ApplicationPolicy
    CRUD_ACTIONS = %i[new create edit update destroy show index].freeze

    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def index?
      true
    end

    def show?
      scope.where(id: record.id).exists?
    end

    def create?
      false
    end

    def new?
      create?
    end

    def update?
      owner_user? || system_user?
    end

    def edit?
      update?
    end

    def destroy?
      false
    end

    def scope
      Pundit.policy_scope! user, record.class
    end

    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        scope
      end
    end

    private

    def system_user?
      user.present? && user.has_role?(:system)
    end


    def admin_user?
      user.present? && user.has_role?(:admin)
    end

    def owner_user?
      user.present? && user.persisted? && user.id == record.user_id
    end
  end

