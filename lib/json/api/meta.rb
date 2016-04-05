module JSON
  module API
    # c.f. http://jsonapi.org/format/#document-meta
    class Meta
      def initialize(meta_hash, options={})
        fail InvalidDocument, "the value of 'meta' MUST be an object" unless
          meta_hash.is_a?(Hash)

        @meta = meta_hash
      end

      def defined?(meta_key)
        @meta.key?(meta_key.to_s)
      end

      def [](meta_key)
        @meta[meta_key.to_s]
      end

      def keys
        @meta.keys
      end
    end
  end
end
