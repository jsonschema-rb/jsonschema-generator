# frozen_string_literal: true

module Jsonschema
  module Generator
    ROOT_TITLE = 'Root'

    # Draft 07
    class Draft07
      def initialize(raw_json, options = {})
        @raw_json = raw_json
        @options = options
        @parsed_json = parse(raw_json)
      end

      def call
        raise Error, 'Invalid Input. JSON expected' unless parsed_json

        { 'title' => ROOT_TITLE }.merge(generate(parsed_json))
      end

      private

      attr_reader :raw_json, :options, :parsed_json

      def parse(json)
        JSON.parse(json)
      rescue StandardError
        nil
      end

      def generate(input)
        case input
        when Hash
          generate_object(input)
        when Array
          generate_array(input)
        else
          Hash['type', TypeDeterminant.call(input)]
        end
      end

      def generate_object(hash)
        params = {
          'properties' => {},
          'type' => 'object',
          'required' => hash.keys,
        }

        hash.each_with_object(params) do |(key, value), memo|
          memo['properties'].merge!(Hash[key, generate(value)])
        end
      end

      def generate_array(array)
        params = {
          'type' => 'array',
          'minItems' => array.size,
          'items' => {},
        }

        array.each_with_object(params) do |elem, memo|
          memo['items'].merge!(generate(elem))
        end
      end
    end
  end
end
