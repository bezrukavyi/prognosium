module Support
  class DataHelper
    class << self
      def round(data, size = 3)
        data.map { |value| value.nil? ? value : value.round(size) }
      end
    end
  end
end
