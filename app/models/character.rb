class Character < OpenStruct
  attr_reader :service

  def initialize
    @service = MarvelService.new
  end

  def sort_characters(params)
    service.all_characters(params).sort_by {|character| character[:comics][:available] }.reverse
  end
end
