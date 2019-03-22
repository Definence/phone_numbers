module Requests
  module JsonHelpers
    def json
      return @json = 'empty response is returned' if response.body.empty?

      parse(response.body)
    end

    def parse(json)
      JSON.parse(json, object_class: OpenStruct)
    end
  end
end
