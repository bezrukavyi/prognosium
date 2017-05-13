module Prognosium
  class Dispatcher
    FORECASTS = {
      brown: Adaptive::Brown,
      holt: Adaptive::Holt,
      mc_kanzey: Adaptive::McKanzee
    }.freeze

    class << self
      def call(type, options)
        forecast(type).new(options)
      end

      def best_forecast(options)
        forecasts(options).min_by { |_type, forecast| forecast.error_percent }[1]
      end

      private

      def forecast(type)
        FORECASTS.fetch(type) { raise 'Not found forecast' }
      end

      def forecasts(options)
        FORECASTS.map { |type, forecast| [type, forecast(type).new(options)] }.to_h
      end
    end
  end
end
