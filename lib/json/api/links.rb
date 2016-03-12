module JSON
  module API
    # c.f. http://jsonapi.org/format/#document-links
    class Links
      def initialize(links_hash, options = {})
        fail InvalidDocument, "the value of 'links' MUST be an object" unless
          links_hash.is_a?(Hash)
        @links = links_hash
        @links.each do |link_name, link_val|
          instance_variable_set("@#{link_name}", Link.new(link_val, options))
          singleton_class.class_eval { attr_reader link_name }
        end
      end

      def defined?(link_name)
        @links.key?(link_name.to_s)
      end
    end
  end
end
