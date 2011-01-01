module Konnect
  class Path < Array
    def has_common_point? other
      !!(detect {|point| other.include?(point) } or other.detect {|point| self.include?(point) })
    end
  end
end
