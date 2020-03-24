module Somecache
  class Custom
    def initialize(namespace:, cache:, **options)
      @namespace = namespace
      @options = options
      @cache = cache
    end

    def fetch(key, &block)
      @cache.fetch(key_with_namespace(key), **@options, &block)
    end

    def write(key, value)
      @cache.write(key_with_namespace(key), value, **@options)
    end

    def read(key)
      @cache.read(key_with_namespace(key), **@options)
    end

    def delete(key)
      @cache.delete(key_with_namespace(key))
    end

    private

    def key_with_namespace(key)
      "#{@namespace}/#{key}"
    end
  end
end
