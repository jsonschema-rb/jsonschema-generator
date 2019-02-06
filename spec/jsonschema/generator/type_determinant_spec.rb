# frozen_string_literal: true

RSpec.describe Jsonschema::Generator::TypeDeterminant do
  subject(:determinant) { described_class.call(input) }

  let(:input) { nil }

  describe 'Success' do
    context 'when boolean' do
      context 'when true' do
        let(:input) { true }

        specify { expect(determinant).to eq 'boolean' }
      end

      context 'when true' do
        let(:input) { false }

        specify { expect(determinant).to eq 'boolean' }
      end
    end

    context 'when integer' do
      let(:input) { 2 }

      specify { expect(determinant).to eq 'integer' }
    end

    context 'when string' do
      let(:input) { 'sss' }

      specify { expect(determinant).to eq 'string' }
    end

    context 'when object' do
      let(:input) { { a: 1 } }

      specify { expect(determinant).to eq 'object' }
    end

    context 'when array' do
      let(:input) { [1] }

      specify { expect(determinant).to eq 'array' }
    end

    context 'when float' do
      let(:input) { 0.512612 }

      specify { expect(determinant).to eq 'number' }
    end

    context 'when nil' do
      let(:input) { nil }

      specify { expect(determinant).to eq 'null' }
    end
  end

  describe 'Fail' do
    let(:input) { Class.new }

    specify do
      expect { determinant }
        .to raise_error(Jsonschema::Generator::Error, 'Wrong input type Class')
    end
  end
end
