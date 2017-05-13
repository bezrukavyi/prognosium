module Prognosium
  module Adaptive
    describe Holt, type: :value do
      let(:data) { [106.94, 106.82, 106, 106.1] }
      let(:options) { { alpha: 0.3, beta: 0.8, period: 3, data: data } }

      subject { Holt.new(options) }

      it 'user default value if options blank' do
        [:alpha, :beta, :period].each do |param|
          options[param] = nil
        end
        subject = Holt.new(options)
        [:alpha, :beta, :period].each do |param|
          expect(subject.send(param)).to eq(Holt::PARAMS[param])
        end
      end

      describe '#forecast' do
        before do
          allow(subject).to receive(:predicted).and_return([])
        end

        it 'forecast' do
          forecast = Support::DataHelper.round(subject.forecast)
          expect(forecast).to eq([nil, 106.94, 106.875, 106.374, 105.987, 105.683, 105.378])
        end

        it 'calc trend and smoothed' do
          subject.forecast
          smoothed = subject.smoothed.map { |value| value.round(3) }
          trend = subject.trend.map { |value| value.round(3) }
          expect(smoothed).to eq([106.94, 106.904, 106.613, 106.292])
          expect(trend).to eq([0, -0.029, -0.239, -0.305])
        end
      end

      it '#deviation_errors' do
        errors = Support::DataHelper.round(subject.deviation_errors)
        expect(errors).to eq([nil, 0.12, 0.875, 0.274])
      end

      it '#error_percent' do
        expect(subject.error_percent).to eq(0.17)
      end
    end
  end
end
