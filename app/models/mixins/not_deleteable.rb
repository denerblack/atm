module Mixins::NotDeleteable
  extend ActiveSupport::Concern

  included do
    default_scope ->{ where(deleted_at: nil) }

    def destroy
      run_callbacks :destroy do
        unless self.respond_to? :deleted_at
          raise MissingMigrationException
        end
        self.update_attribute :deleted_at, DateTime.now
      end
    end

    def delete
      self.destroy
    end
  end

end

class MissingMigrationException < Exception
  def message
    "Model is lacking the deleted boolean field for NotDeleteable to work"
  end
end
