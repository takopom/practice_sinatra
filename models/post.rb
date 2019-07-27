class Post

  attr_reader :name
  attr_accessor :memo

  def initialize(name, memo)
    @name = name
    @memo = memo
  end

end