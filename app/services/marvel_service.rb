require 'digest'

class MarvelService

  def initialize
    @connection = Faraday.new(url: 'https://gateway.marvel.com/v1/public/')
  end

  def characters(params)
    JSON.parse(response(params).body, symbolize_names: true)[:data][:results]
  end

  private

    def response(params = {})
      @connection.get('characters', params.merge(access_params))
    end

    def public_key
      ENV['MARVEL_PUBLIC_KEY']
    end

    def private_key
      ENV['MARVEL_PRIVATE_KEY']
    end

    def access_params
      timestamp = Time.now.to_s
      hash = Digest::MD5.hexdigest(timestamp + private_key + public_key)
      { ts: timestamp,
        apikey: public_key,
        hash: hash }
    end
end
