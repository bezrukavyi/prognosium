module Prognosium
  module Adaptive
    class McKanzee < Holt
      attr_reader :fi

      PARAMS = { alpha: 0.3, beta: 0.8, fi: 0.95, period: 3 }.freeze

      def initialize(options)
        @fi = options[:fi] || PARAMS[:fi]
        super
      end

      def calc_smoothed(data_value, prev_smoothed, prev_trend)
        alpha * data_value + (1 - alpha) * (prev_smoothed + prev_trend) * fi
      end

      def calc_trend(smoothed_value, prev_smoothed, prev_trend)
        beta * (smoothed_value - prev_smoothed) + (1 - beta) * prev_trend * fi
      end

      def predicted_formula(index)
        smoothed.last + trend.last * index * fi
      end
    end
  end
end
