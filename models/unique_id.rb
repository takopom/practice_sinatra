class UniqueID

  DIR_PATH = './posts'
  FILE_PATH = './posts/id.txt'
  START_ID = '1'

  def self.id
    value = START_ID
    FileUtils.mkdir_p(DIR_PATH)
    File.open(FILE_PATH, File::RDWR|File::CREAT) do |f|
        f.flock(File::LOCK_EX)
      puts "#{f.size}"
      if f.size > 0 then
        value = f.read.to_i + 1
      end
      f.rewind
      f.puts("#{value}")
      f.flock(File::LOCK_UN)
    end
    value
  end

end