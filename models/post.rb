class Post

  attr_reader :name
  attr_accessor :memo

  PATH = './posts'
  FILE_EXT = '.markdown'

  def initialize(name, memo)
    @name = name
    @memo = memo
  end

  def self.init
    Dir.mkdir(PATH) if !Dir.exist?(PATH)
  end

  def self.all
    posts = File.join(PATH, '*' + FILE_EXT)
    names = Dir.glob(posts).map { |item| File.basename(item, FILE_EXT) }
    names.sort.reverse
  end

  def self.path(name)
    "#{PATH}/#{name}#{FILE_EXT}"
  end

  def self.find(name)
    memo = ""
    File.open(path(name), "r") do |f|
      memo = f.read()
    end
    Post.new(name, memo)
  end

  def save
    File.open(Post.path(@name), "w") do |f|
      f.puts(@memo)
    end
  end

  def destroy
    filepath = Post.path(@name)
    File.delete(filepath) if File.exist?(filepath)
  end

end