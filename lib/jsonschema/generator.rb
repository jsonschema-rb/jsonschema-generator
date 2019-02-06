# frozen_string_literal: true

require 'json'
require 'jsonschema/generator/version'
require 'jsonschema/generator/type_determinant'
require 'jsonschema/generator/draft07'

module Jsonschema
  # Generator
  module Generator
    class Error < StandardError; end

    class << self
      def call(json)
        Draft07.new(json).call
      end
    end
  end
end
