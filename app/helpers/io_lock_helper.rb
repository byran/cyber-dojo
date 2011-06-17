module IOLockHelper

  def io_lock(path, &block)
    result = nil
    File.open(path, 'r') do |fd|
      if fd.flock(File::LOCK_EX)
        begin
          result = block.call(fd)
        ensure
          fd.flock(File::LOCK_UN)
        end
      end
    end
    result
  end

end