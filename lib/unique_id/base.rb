require 'active_support/concern'

module UniqueId
  module Base
    extend ActiveSupport::Concern

    included do
      before_create :generate_unique
    end

    def unique_type
      self.class.to_s
    end

    def unique_scope
      if scope = self.class.unique.scope
        @unique_scope ||= case scope
          when Symbol then self.send(scope)
          when Proc   then self.instance_exec(&scope)
          else scope
        end
      end
    end

    def unique_format(value)
      if f = self.class.unique.formatter
        return self.instance_exec(self.unique_scope, value, &f)
      end
      value
    end

    def generate_unique
      value = unique_format(self.class.unique.next(scope:self.unique_scope, type:self.unique_type))
      write_attribute self.class.unique.attribute, value
    end

    module ClassMethods
      attr_accessor :unique

      def has_unique(*args)
        opts = args.extract_options!
        @unique = ::Unique::Generator.new(args.first, opts)
      end
    end
  end
end
