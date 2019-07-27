require './models/post.rb'

class PostFile

  PATH = './posts'
  FILE_EXT = '.markdown'

  def path(name)
    "#{PATH}/#{name}#{FILE_EXT}"
  end

  def make_dir
    Dir.mkdir(PATH) if !Dir.exist?(PATH)
  end

  def all
    make_dir()
    mdfiles = File.join(PATH, '*' + FILE_EXT)
    Dir.glob(mdfiles).map { |item| file_name(item) }
  end

  def sort(names)
    names.sort.reverse
  end

  def file_name(filepath)
    File.basename(filepath, FILE_EXT)
  end

  def write(post)
    write_file(path(post.name), post.memo)
  end

  def write_file(filepath, text)
    make_dir()
    File.open(filepath, "w") do |f|
      f.puts(text)
    end
  end

  def read(name)
    memo = read_file(path(name))
    Post.new(name, memo)
  end

  def read_file(filepath)
    make_dir()
    text = ""
    File.open(filepath, "r") do |f|
      text = f.read()
    end
    text
  end

  def delete(post_name)
    delete_file(path(post_name))
  end

  def delete_file(filepath)
    File.delete(filepath) if File.exist?(filepath)
  end

end