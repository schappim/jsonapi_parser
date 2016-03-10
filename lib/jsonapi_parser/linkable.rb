module JsonApiParser
  module Linkable
    def link_defined?(link_name)
      @links_hash.key?(link_name.to_s)
    end

    def links_keys
      @links_hash.keys
    end
  end
end
