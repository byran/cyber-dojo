#!/usr/bin/env ruby

require_relative 'lib_test_base'

class ExternalsTests < LibTestBase

  include ExternalSetter
  include ExternalDiskDir
  include ExternalGit
  include ExternalRunner
  include ExternalExercisesPath
  include ExternalLanguagesPath
  include ExternalKatasPath

  def setup
    reset_external(:disk, nil)
    reset_external(:git, nil)
    reset_external(:runner, nil)
    reset_external(:exercises_path, nil)
    reset_external(:languages_path, nil)
    reset_external(:katas_path, nil)
  end

  test 'raises RuntimeError if disk not set' do
    assert_raises(RuntimeError) { disk }
  end

  test 'raises RuntimeError if git not set' do
    assert_raises(RuntimeError) { git }
  end

  test 'raises RuntimeError if runner not set' do
    assert_raises(RuntimeError) { runner }
  end

  test 'raises RuntimeError if exercises_path not set' do
    assert_raises(RuntimeError) { exercises_path }
  end

  test 'raises RuntimeError if languages_path not set' do
    assert_raises(RuntimeError) { languages_path }
  end

  test 'raises RuntimeError if katas_path not set' do
    assert_raises(RuntimeError) { katas_path }
  end

  test 'when disk is set it is not overridden' do
    reset_external(:disk, Object.new)
    assert_equal 'Object', disk.class.name
  end

  test 'when git is set it is not overridden' do
    reset_external(:git, Object.new)
    assert_equal 'Object', git.class.name
  end

  test 'when runner is set it is not overridden' do
    reset_external(:runner, Object.new)
    assert_equal 'Object', runner.class.name
  end

  test 'dir is disk[path]' do
    reset_external(:disk, DiskFake.new)
    assert_equal path, dir.path
  end

  def path
    'fubar/'
  end

end
