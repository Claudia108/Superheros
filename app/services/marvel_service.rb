require 'digest'

class MarvelService

  def initialize
    @connection = Faraday.new(url: 'https://gateway.marvel.com/v1/public/')
  end

  def characters(params)
    result(params)[:data][:results]
  end

  def all_characters(params)
    # until total is reached get characters with limit 100 and offset + 100
    params = { offset: 0}
    total_characters = []
    i = (total(params).to_f / 100).ceil
    i.times do
      total_characters << characters(params)
      i -= 1
      params[:offset] += 100
    end
    total_characters.flatten
  end

  def total(params)
    result(params)[:data][:total]
  end

  private

    def result(params)
      JSON.parse(response(params).body, symbolize_names: true)
    end

    def response(params)
      params = { limit: 100 }
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
