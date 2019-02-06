# frozen_string_literal: true

RSpec.describe Jsonschema::Generator do
  subject(:generator) { described_class.call(json) }

  let(:json) { {}.to_json }

  describe 'Success' do
    let(:draft07) { instance_double(described_class::Draft07) }

    it 'calls draft07 with correct input' do
      expect(described_class::Draft07)
        .to receive(:new).with(json).and_return(draft07)
      expect(draft07).to receive(:call)

      generator
    end
  end
end
