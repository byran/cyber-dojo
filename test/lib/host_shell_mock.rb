
class HostShellMock

  def initialize(dojo)
    @target = HostShell.new(dojo)
    @cd_exec_mock = []
    @exec_mock = []
    @daemon_exec_mock = []
  end

  # - - - - - - - - - - - - - - - - -

  def teardown
    raise "#{self.class.name} unused #{@cd_exec_mock}"     unless @cd_exec_mock == []
    raise "#{self.class.name} unused #{@exec_mock}"        unless @exec_mock == []
    raise "#{self.class.name} unused #{@daemon_exec_mock}" unless @daemon_exec_mock == []
  end

  # - - - - - - - - - - - - - - - - -

  def mock_cd_exec(path, commands, output, exit_status)
    @cd_exec_mock << {
      :path => path,
      :commands => commands,
      :output => output,
      :exit_status => exit_status
    }
  end

  # - - - - - - - - - - - - - - - - -

  def mock_exec(commands, output, exit_status)
    @exec_mock << {
      :commands => commands,
      :output => output,
      :exit_status => exit_status
    }
  end

  # - - - - - - - - - - - - - - - - -

  def mock_daemon_exec(command)
    @daemon_exec_mock << {
      :command => command
    }
  end

  # - - - - - - - - - - - - - - - - -

  def cd_exec(path, *commands)
    return @target.cd_exec(path, *commands) if @cd_exec_mock == []
    mock = @cd_exec_mock.shift
    if [path,commands] != [mock[:path],mock[:commands]]
      raise "cd_exec(#{path},#{commands}), expected cd_exec(#{mock[:path]}, #{mock[:commands]}"
    end
    return mock[:output], mock[:exit_status]
  end

  # - - - - - - - - - - - - - - - - -

  def exec(*commands)
    return @target.exec(*commands) if @exec_mock == []
    mock = @exec_mock.shift
    if commands != mock[:commands]
      raise "exec(#{commands}), expected exec(#{mock[:commands]})"
    end
    return mock[:output], mock[:exit_status]
  end

  # - - - - - - - - - - - - - - - - -

  def daemon_exec(command)
    return @target.daemon_exec(command) if @daemon_exec_mock == []
    mock = @daemon_exec_mock.shift
    if command != mock[:command]
      raise "daemon_exec(#{command}), expected daemon_exec(#{mock[:command]})"
    end
  end

  # - - - - - - - - - - - - - - - - -

  def success
    0
  end

end
