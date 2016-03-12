module JSON
  module API
    # c.f. http://jsonapi.org/format/#document-resource-object-attributes
    class Attributes
      def initialize(attributes_hash, options = {})
        fail InvalidDocument,
             "the value of 'attributes' MUST be an object" unless
          attributes_hash.is_a?(Hash)
        @attributes = attributes_hash
        @attributes.each do |attr_name, attr_val|
          instance_variable_set("@#{attr_name}", attr_val)
          singleton_class.class_eval { attr_reader attr_name }
        end
      end
    end
  end
end
