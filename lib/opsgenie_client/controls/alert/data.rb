module OpsGenieClient
  module Controls
    module Alert
      module Data
        def self.example
          data = OpsGenieClient::Data.build

          data.api_key = api_key
          data.message = message
          data.description = description
          data.source = source
          data.entity = entity
          data.details = details
          data.note = note

          data
        end

        def self.api_key
          'some api key'
        end

        def self.message
          'some message'
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
            reference_time = Controls::Data.time

            {
              'occurredOn' => reference_time,
              'details' => {
                'machineName' => Controls::Data.machine_name,
                'client' => Client.data,
                'error' => Error.data,
                'tags' => Controls::Data.tags,
                'userCustomData' => Controls::Data.custom_data
              }
            }
          end
        end
      end
    end
  end
end
