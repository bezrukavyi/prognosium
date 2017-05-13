module Prognosium
  module Adaptive
    class Base
      attr_reader :data, :forecast, :deviation_errors, :error_percent,
                  :predicted, :forecast_dates

      def initialize(options)
        @data = options[:data]
        @forecast = calc_forecast.unshift(nil)
        @deviation_errors = calc_errors
        @error_percent = calc_mape
      end

      def forecast_dates(dates)
        period.times { |index| dates << (index + 1).to_s }
        dates
      end

      def predicted
        calc_predicted
      end

      private

      def calc_forecast
        raise 'Need redefined'
      end

      def calc_errors
        (0...data.size).to_a.map do |index|
          next unless forecast[index]
          (data[index] - forecast[index]).abs
        end
      end

      def calc_mape
        errors = deviation_errors.each_with_index.map do |error, index|
          next if error.nil? || forecast[index].nil?
          error / forecast[index]
        end
        ((errors.compact.inject(0, :+) / forecast.size) * 100).round(3)
      end

      def calc_average(array_data)
        array_data.inject(0, :+) / array_data.size
      end

      def calc_predicted
        (1..period).to_a.map do |index|
          yield(index)
        end
      end
    end
  end
end
