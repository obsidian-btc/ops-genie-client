module OpsGenieClient
  module Alert
    module HTTP
      class Post
        def self.logger
          @logger ||= ::Telemetry::Logger.get self
        end

        setting :api_key

        attr_reader :data

        dependency :telemetry, ::Telemetry
        dependency :logger, ::Telemetry::Logger
        dependency :http_post, ::HTTP::Commands::Post

        def self.build(connection: nil)
          new.tap do |instance|
            OpsGenieClient::Settings.set(instance)

            ::Telemetry.configure instance
            ::Telemetry::Logger.configure instance
            ::HTTP::Commands::Post.configure instance, :http_post, connection: connection
          end
        end

        def self.configure(receiver, attr_name=nil)
          attr_name ||= :ops_genie_post
          build.tap do |instance|
            receiver.send "#{attr_name}=", instance
          end
        end

        def self.call(data)
          instance = build
          instance.(data)
        end

        def call(data)
          logger.trace "Posting to OpsGenie"

          data.api_key = api_key

          json_text = Serialize::Write.(data, :json)

          response = post(json_text)

          telemetry.record :posted, Telemetry::Data.new(data, response)

          logger.info "Posted to OpsGenie (#{LogText::Posted.(data, response)})"

          response
        end

        def self.host
          'api.opsgenie.com'
        end

        def self.path
          '/v1/json/alert'
        end

        def self.uri
          URI::HTTPS.build :host => host, :path => path
        end

        def post(request_body)
          http_post.(request_body, self.class.uri)
        end

        def self.register_telemetry_sink(post)
          sink = Telemetry.sink
          post.telemetry.register sink
          sink
        end

        module Telemetry
          class Sink
            include ::Telemetry::Sink

            record :posted

            module Assertions
              def posts(&blk)
                if blk.nil?
                  return posted_records
                end

                posted_records.select do |record|
                  blk.call(record.data.data, record.data.response)
                end
              end

              def posted?(&blk)
                if blk.nil?
                  return recorded_posted?
                end

                recorded_posted? do |record|
                  blk.call(record.data.data, record.data.response)
                end
              end
            end
          end

          Data = Struct.new :data, :response

          def self.sink
            Sink.new
          end
        end

        module Substitute
          def self.build
            Substitute::Post.build.tap do |substitute|
              sink = OpsGenieClient::Alert::HTTP::Post.register_telemetry_sink(substitute)
              substitute.sink = sink
            end
          end

          class Post < HTTP::Post
            attr_accessor :sink

            def self.build
              new.tap do |instance|
                ::Telemetry.configure instance
                ::Telemetry::Logger.configure instance
              end
            end
          end
        end

        module LogText
          module Posted
            def self.call(data, response)
              "Status Code: #{response.status_code}, Reason Phrase: #{response.reason_phrase}, Message: #{data.message}, Details: #{data.details})"
            end
          end
        end
      end
    end
  end
end
