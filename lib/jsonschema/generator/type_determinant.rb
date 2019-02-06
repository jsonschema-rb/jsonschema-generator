# frozen_string_literal: true

module Jsonschema
  module Generator
    # Returns json_schema type according to value class
    class TypeDeterminant
      # rubocop:disable Metrics/MethodLength
      def self.call(value)
        case value
        when TrueClass, FalseClass
          'boolean'
        when Float
          'number'
        when Hash
          'object'
        when String, Integer, Array
          value.class.to_s.downcase
        when NilClass
          'null'
        else
          raise Error, "Wrong input type #{value.class}"
        end
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
