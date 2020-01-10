module Reliable
  module MapperMethods
    module Customers
      def self.active(status)
        status == 'Active'
      end

      def self.name(*args)
        args.compact.map(&:strip).join(' ')
      end

      def self.billing_phone_kind(phonetype)
        'M'
      end

      def self.customer_type(propertytypename)
        'T'
      end

      def self.billing_term_id(termname)
        ''
      end

      def self.branch_name(name)
        name
      end
    end
  end
end
