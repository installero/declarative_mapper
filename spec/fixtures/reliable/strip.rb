module Shared
  def self.strip(str)
    return str.strip if str.is_a?(String)
  end
end
