require 'digest'

class MarvelService

  def initialize
    @connection = Faraday.new(url: 'https://gateway.marvel.com/v1/public/')
  end

  def characters(params)
    result(params)[:data][:results]
  end

  def total(params)
    result(params)[:data][:total]
  end
  
  def all_characters(params)
    end_of_loop = (total(params) / 100)
    (0..end_of_loop).map do |offset|
      characters({ limit: 100, offset: (offset * 100) })
    end.flatten
  end

  private

    def result(params)
      JSON.parse(response(params).body, symbolize_names: true)
    end

    def response(params)
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
