require 'digest'

class MarvelService

  def initialize
    @connection = Faraday.new(url: 'https://gateway.marvel.com/v1/public/')
  end

  def characters
    result[:data][:results]
  end

  # def all_characters
  #   total_characters = []
  #   i = (total.to_f / 100).ceil
  #   i.times do
  #     total_characters << characters
  #     i -= 1
  #     params[:offset] += 100
  #   end
  #   total_characters.flatten
  # end

  def total
    result[:data][:total]
  end

  private

    def result
      JSON.parse(response.body, symbolize_names: true)
    end

    def response
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
