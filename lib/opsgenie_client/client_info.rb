module OpsGenieClient
  module ClientInfo
    def self.name
      'Obsidian OpsGenie Client'
    end

    def self.version
      '1'
      Gem.loaded_specs['opsgenie_client'].version.version
    end

    def self.url
      'https://github.com/obsidian-btc/opsgenie-client'
    end
  end
end
