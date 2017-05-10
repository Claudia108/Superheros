require 'digest/md5'

class MarvelService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: 'https://gateway.marvel.com/v1/public/')
  end

  def characters
    result
  end

  private

    def result
      JSON.parse(response.body, symbolize_names: true)[:results]
    end

    def response(params = {})
      result = @connection.get "/characters", params.merge(keys)
      binding.pry
    end

    def keys
      ts = DateTime.now
      hash = Digest::MD5.hexdigest("#{ts}#{ENV['MARVEL_PRIVATE_KEY']}#{'MARVEL_PUBLIC_KEY'}").to_s
      {ts: ts,
       apikey: ENV['MARVEL_PUBLIC_KEY'],
       hash: hash }
    end

end
