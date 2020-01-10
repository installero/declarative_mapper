module Shared
  module Phone
    module Number
      def self.normalize(phone_number)
        "+#{phone_number}"
      end
    end
  end
end
