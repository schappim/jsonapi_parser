module JsonApiParser
  # c.f. http://jsonapi.org/format/#document-resource-object-relationships
  class Relationships
    def initialize(relationships_hash, options = {})
      fail InvalidDocument,
           "the value of 'relationships' MUST be an object" unless
        relationships_hash.is_a?(Hash)
      @relationships = relationships_hash
      @relationships.each do |rel_name, rel_hash|
        instance_variable_set("@#{rel_name}",
                              Relationship.new(rel_hash, options))
        singleton_class.class_eval { attr_reader rel_name }
      end
    end
  end
end
