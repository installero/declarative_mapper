module Reliable
  module MapperMethods
    module Customers
      def self.phone_number_normalize(phone_number)
        "+#{phone_number}"
      end
    end
  end
end
