module OpsGenieClient
  module Controls
    module Alert
      module Data
        def self.example(entity: nil, source: nil)
          entity ||= self.entity
          source ||= self.source

          data = OpsGenieClient::Alert::Data.build

          data.api_key = api_key
          data.message = message
          data.description = description
          data.source = source
          data.entity = entity
          data.details = details

          data
        end

        def self.api_key
          'some api key'
        end

        def self.message
          'some alert'
        end

        def self.description
          'some description'
        end

        def self.source
          'some source'
        end

        def self.entity
          'some entity'
        end

        def self.details
          { 'someKey' => 'some value' }
        end

        module JSON
          def self.text
            ::JSON.generate(data)
          end

          def self.data
            {
              'apiKey' => Data.api_key,
              'message' => Data.message,
              'description' => Data.description,
              'source' => Data.source,
              'entity' => Data.entity,
              'details' => Data.details
            }
          end
        end
      end
    end
  end
end
