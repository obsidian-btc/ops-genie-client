module OpsGenieClient
  module Controls
    module Alert
      module Data
        def self.example(custom_data=nil, tags=nil, time: nil)
          custom_data ||= self.custom_data
          tags ||= self.tags
          time ||= self.time

          data = OpsGenieClient::Data.build

          data.occurred_time = time
          data.machine_name = machine_name
          data.tags = tags
          data.custom_data = custom_data

          data.client = OpsGenieClient::Data::ClientInfo.build

          data.error = Controls::ErrorData.example

          data
        end

        def self.time
          ::Controls::Time.reference
        end

        def self.machine_name
          'some machine name'
        end

        def self.tags
          ['some-tag']
        end

        def self.custom_data
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
