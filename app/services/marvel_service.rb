require 'digest/md5'

class MarvelService

  def initialize
    @client = Marvel::Client.new

    @client.configure do |config|
      config.api_key = ENV['MARVEL_PUBLIC_KEY']
      config.private_key = ENV['MARVEL_PRIVATE_KEY']
    end
  end

  def characters
    @client.characters
  end

  # I'd like to use Faraday because it is univerally usable
  # but I get the error "Credentials invalid".
  # Will continue to build with gem and come back later.


  # def initialize
  #   @connection = Faraday.new(url: 'https://gateway.marvel.com/v1/public')
  # end
  #
  # def characters
  #   result
  # end
  #
  # private
  #
  #   def result
  #     JSON.parse(response.body, symbolize_names: true)[:results]
  #   end
  #
  #   def response(params = {})
  #     @connection.get "/characters", params.merge(keys)
  #   end
  #
  #   def keys
  #     ts = SecureRandom.urlsafe_base64
  #     hash = Digest::MD5.hexdigest("#{ts} #{ENV['MARVEL_PRIVATE_KEY']} #{'MARVEL_PUBLIC_KEY'}").to_s
  #     # hash = Digest::MD5.new.update("#{ts}#{ENV['MARVEL_PRIVATE_KEY']}#{'MARVEL_PUBLIC_KEY'}").to_s
  #     {ts: ts,
  #      apikey: ENV['MARVEL_PUBLIC_KEY'],
  #      hash: hash }
  #   end

end
