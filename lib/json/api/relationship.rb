module JSON
  module API
    # c.f. http://jsonapi.org/format/#document-resource-object-relationships
    class Relationship
      attr_reader :data, :links, :meta

      def initialize(relationship_hash, options = {})
        @options = options
        @links_defined = relationship_hash.key?('links')
        links_hash = relationship_hash['links'] || {}
        @links = Links.new(links_hash, @options)
        @data = parse_linkage(relationship_hash['data']) if
          relationship_hash.key?('data')
        @meta = relationship_hash['meta'] if relationship_hash.key?('meta')

        validate!
      end

      def collection?
        @data.is_a?(Array)
      end

      private

      def validate!
        case
        when !@links_defined && !@data && !@meta
          fail InvalidDocument,
               "a relationship object MUST contain at least one of 'links'," \
               " 'data', or 'meta'"
        when @links_defined &&
             !@links.defined?(:self) &&
             !@links.defined?(:related)
          fail InvalidDocument,
               "the 'links' object of a relationship object MUST contain at" \
               " least one of 'self' or 'related'"
        end
      end

      def parse_linkage(linkage_hash)
        collection = linkage_hash.is_a?(Array)
        if collection
          linkage_hash.map { |h| ResourceIdentifier.new(h, @options) }
        elsif linkage_hash.nil?
          nil
        else
          ResourceIdentifier.new(linkage_hash, @options)
        end
      end
    end
  end
end
