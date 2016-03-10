module OpsGenieClient
  class Data
    class ClientInfo
      include Schema::DataStructure

      attribute :name, String
      attribute :version, String
      attribute :client_url, String

      def ==(other)
        name == other.name &&
          version == other.version &&
          client_url == other.client_url
      end

      def to_s
        "#{name} v#{version} (#{url})"
      end

      def self.build
        instance = new

        instance.name = OpsGenieClient::ClientInfo.name
        instance.version = OpsGenieClient::ClientInfo.version
        instance.client_url = OpsGenieClient::ClientInfo.url

        instance
      end
    end
  end
end
