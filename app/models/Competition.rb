
class Competition

  def initialize(cyberdojo_path, disk)
    @cyberdojo_path,@disk = cyberdojo_path,disk
  end

  def path
    @cyberdojo_path + 'competition/'
  end

  def dir
    disk[path]
  end

  def exists?
    dir.exists?
  end

  def create_entry(id, fullname, email, publish, career, news, age, ip)
    output = {
      :id => id.to_s[0..5],
      :fullname => fullname,
      :email => email,
      :publish => publish,
      :career => career,
      :news => news,
      :age => age,
      :ip => ip,
      :time => Time.now
    }
    dir.write(id + ".json", output)
  end

  def read_entry(id)
    read_entry_file(id + ".json")
  end

  def each
    dir.each do |filename|
      yield read_entry_file(filename) if filename.end_with?('.json')
    end
  end

private


  def read_entry_file(filename)
    data = JSON.parse(dir.read(filename))
    {
      :id => data["id"],
      :fullname => data["fullname"],
      :email => data["email"],
      :publish => data["publish"],
      :career => data["career"],
      :news => data["news"],
      :age => data["age"],
      :ip => data["ip"],
      :time => data["time"]
    }
  end

  def disk
    @disk
  end

end

