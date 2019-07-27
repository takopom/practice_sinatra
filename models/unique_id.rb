class UniqueID

  PATH = './posts'
  FILE_NAME = 'id.txt'
  START_ID = '1'

  def path
    "#{PATH}/#{FILE_NAME}"
  end

  def make_dir
    Dir.mkdir(PATH) if !Dir.exist?(PATH)
  end

  def init_id
    write(START_ID)
  end

  def id
    init_id if !File.exist?(path())
    read().to_i
  end

  def increment
    id = read().to_i + 1
    write(id.to_s)
  end

  def read()
    make_dir()
    text = ""
    File.open(path(), "r") do |f|
      text = f.read()
    end
    text
  end

  def write(text)
    make_dir()
    File.open(path(), "w") do |f|
      f.puts(text)
    end
  end

end