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

  def make_file
    FileUtils.touch(path()) if !File.exist?(path())
  end

  def id
    value = START_ID
    make_dir()
    make_file()
    
    File.open(path(), "r+") do |f|
      f.flock(File::LOCK_EX)
      puts "#{f.size}"
      if f.size == 0 then
        value = START_ID
      else
        value = f.read.to_i + 1
      end
      f.rewind
      f.puts("#{value}")
      f.flock(File::LOCK_UN)
    end
    value
  end

end