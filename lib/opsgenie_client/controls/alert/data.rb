module OpsGenieClient
  module Controls
    module Alert
      module Data
        def self.example
          data = OpsGenieClient::Alert::Data.build

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

        def self.note
raise 'remove note field. it operates as a comments field. put client info somewhere else.'
          'some note'
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
