module Prognosium
  module Adaptive
    class Brown < Base
      attr_accessor :alpha

      PARAMS = { alpha: 0.3 }.freeze

      def initialize(options)
        @alpha = options[:alpha] || PARAMS[:alpha]
        super(options)
      end

      def forecast_dates(dates)
        dates << 1
      end

      private

      def calc_forecast
        forecast_data = []
        data.size.times do |index|
          next forecast_data << data[index] if index.zero?
          forecast_data << formula(data[index], forecast_data[index - 1])
        end
        forecast_data
      end

      def calc_predicted
        []
      end

      def formula(initial_value, forecast_value)
        return initial_value unless forecast_value
        (alpha * initial_value + (1 - alpha) * forecast_value)
      end
    end
  end
end
