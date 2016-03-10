require 'jsonapi_parser/linkable'
require 'jsonapi_parser/exceptions'

require 'jsonapi_parser/attributes'
require 'jsonapi_parser/document'
require 'jsonapi_parser/error'
require 'jsonapi_parser/jsonapi'
require 'jsonapi_parser/link'
require 'jsonapi_parser/links'
require 'jsonapi_parser/relationship'
require 'jsonapi_parser/relationships'
require 'jsonapi_parser/resource'
require 'jsonapi_parser/resource_identifier'
require 'jsonapi_parser/version'

module JsonApiParser
  module_function

  def parse(hash, options = {})
    Document.new(hash, options)
  end
end
