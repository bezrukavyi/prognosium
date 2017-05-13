module Prognosium
  module Adaptive
    describe Brown, type: :value do
      let(:data) { [106.94, 106.82, 106, 106.1] }
      let(:options) { { alpha: 0.3, data: data } }

      subject { Brown.new(options) }

      it 'user default value if options blank' do
        options[:alpha] = nil
        subject = Brown.new(options)
        expect(subject.alpha).to eq(Brown::PARAMS[:alpha])
      end

      it '#forecast' do
        forecast = Support::DataHelper.round(subject.forecast)
        expect(forecast).to eq([nil, 106.94, 106.904, 106.633, 106.473])
      end

      it '#deviation_errors' do
        errors = Support::DataHelper.round(subject.deviation_errors)
        expect(errors).to eq([nil, 0.12, 0.904, 0.533])
      end

      it '#error_percent' do
        expect(subject.error_percent).to eq(0.291)
      end
    end
  end
end
