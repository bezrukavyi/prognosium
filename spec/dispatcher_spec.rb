module Prognosium
  describe Dispatcher, type: :value do
    let(:options) { { alpha: 0.8, beta: 0.3, period: 3, type: :holt } }
    let(:data) { [106.94, 106.82, 106, 106.1] }

    it '.call' do
      expect(Adaptive::Holt).to receive(:new).with(options)
      Dispatcher.call(:holt, options)
    end

    it '.best_forecast' do
      data = [
        106.94, 106.82, 106, 106.1, 106.73, 107.73, 107.7, 108.36,
        105.52, 103.13, 105.44, 107.95, 111.77, 115.57, 114.92,
        113.58, 113.57, 113.55, 114.62, 112.71
      ]
      best_forecast = Dispatcher.best_forecast(data: data)
      expect(best_forecast).to be_an_instance_of(Adaptive::Brown)
    end
  end
end
