require 'json/api/linkable'
require 'json/api/exceptions'

require 'json/api/attributes'
require 'json/api/document'
require 'json/api/error'
require 'json/api/jsonapi'
require 'json/api/link'
require 'json/api/links'
require 'json/api/relationship'
require 'json/api/relationships'
require 'json/api/resource'
require 'json/api/resource_identifier'
require 'json/api/version'

module JSON
  module API
    module_function

    def parse(hash, options = {})
      Document.new(hash, options)
    end
  end
end
