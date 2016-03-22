module OpsGenieClient
  module Alert
    class Data
      include Schema::DataStructure

      attribute :api_key
      attribute :message
      attribute :description
      attribute :source
      attribute :entity
      attribute :details

      def ==(other)
        self.class == other.class &&
          message == other.message &&
          description == other.description &&
          source == other.source &&
          entity == other.entity &&
          details == other.details
      end

      module Serializer
        def self.json
          JSON
        end

        def self.raw_data(instance)
          instance.to_h
        end

        module JSON
          def self.serialize(raw_data)
            formatted_data = Casing::Camel.(raw_data)
            ::JSON.generate(formatted_data)
          end
        end
      end
    end
  end
end
