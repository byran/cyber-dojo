# See comments at end of file

class Avatar

  def initialize(kata, name)
    @kata = kata
    @name = name
  end

  # queries

  attr_reader :kata, :name

  def parent
    kata
  end

  def path
    # The avatar's folder holds its manifest and increments caches
    kata.path + name + '/'
  end

  def diff(was_tag, now_tag)
    git.diff(path, was_tag, now_tag)
  end

  def active?
    # Players sometimes start an extra avatar solely to read the
    # instructions. I don't want these avatars appearing on the dashboard.
    # When forking a new kata you can enter as one animal to sanity check
    # it is ok (but not press [test])
    exists? && !lights.empty?
  end

  def tags
    ([tag0] + increments).map { |h| Tag.new(self, h) }
  end

  def lights
    tags.select(&:light?)
  end

  def visible_filenames
    visible_files.keys
  end

  def visible_files
    read_json(manifest_filename)
  end

  def sandbox
    # The avatar's sandbox holds its source files
    Sandbox.new(self)
  end

  # modifiers

  def start
    dir.make
    git.setup(path, user_name, user_email)
    write_manifest(kata.visible_files)
    git.add(path, manifest_filename)
    write_increments([])
    git.add(path, increments_filename)
    sandbox.start
    git.commit(path, 0)
  end

  def test(delta, files, now = time_now, max_seconds = 15)
    sandbox.save_files(delta, files)
    output = truncated(sandbox.run_tests(max_seconds))
    colour = language.colour(output)

    update_manifest(files, output)
    rags = update_increments(colour, now)
    git.commit(path, rags[-1]['number'])

    [rags, output]
  end

  private

  include ExternalParentChainer
  include ExternalDir
  include OutputTruncater
  include TimeNow

  # - - - - - - - - - - - - - - - - -

  def write_manifest(files)
    # The manifest stores a cache of the avatar's
    # current visible files [filenames and contents].
    write_json(manifest_filename, files)
  end

  def update_manifest(files, output)
    # output _is_ part of diff state
    disk[sandbox.path].write('output', output)
    files['output'] = output
    write_manifest(files)
  end

  def manifest_filename
    'manifest.json'
  end

  # - - - - - - - - - - - - - - - - -

  def write_increments(increments)
    # Stores a cache of colours and time-stamps for all the
    # avatar's current [test]s. Helps optimize the review dashboard.
    write_json(increments_filename, increments)
  end

  def update_increments(colour, now)
    # rags = Reds/Ambers/Greens
    rags = increments
    tag = rags.length + 1
    rags << { 'colour' => colour, 'time' => now, 'number' => tag }
    write_increments(rags)
    rags
  end

  def increments
    read_json(increments_filename)
  end

  def increments_filename
    'increments.json'
  end

  # - - - - - - - - - - - - - - - - -

  def tag0
    @zeroth ||=
    {
      'event'  => 'created',
      'time'   => time_now(kata.created),
      'number' => 0
    }
  end

  def language
    # Each avatar does _not_ choose their own language+test.
    # The language+test is chosen for the _dojo.
    # cyber-dojo is a team-based learning environment,
    # not an individual development environment
    kata.language
  end

  # - - - - - - - - - - - - - - - - -

  def user_name
    "#{name + '_' + kata.id}"
  end

  def user_email
    "#{name}@cyber-dojo.org"
  end

end

#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# tags vs lights
#- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# When a new avatar enters a dojo, kata.start_avatar()
# will do a 'git commit' + 'git tag' for tag 0 (zero).
# This initial tag is *not* recorded in the
# increments.json file which starts as [ ]
# It probably should be but isn't for existing dojos
# and so for backwards compatibility it stays that way.
#
# All subsequent 'git commit' + 'git tag' commands
# correspond to a gui action and store an entry in the
# increments.json file.
# eg
# [
#   {
#     'colour' => 'red',
#     'time'   => [2014, 2, 15, 8, 54, 6],
#     'number' => 1
#   },
# ]
#
# At the moment the only gui action that creates an
# increments.json file entry is a [test] event.
#
# However, I may create finer grained tags than
# just [test] events...
#    o) creating a new file
#    o) renaming a file
#    o) deleting a file
#    o) opening a different file
#    o) editing a file
#
# If this happens the difference between tags and lights
# will be more pronounced.
# ------------------------------------------------------
# Invariants
#
# If the latest tag is N then
#   o) increments.length == N
#   o) tags.length == N+1
#
# The inclusive upper bound for n in avatar.tags[n] is
# always the current length of increments.json (even if
# that is zero) which is also the latest tag number.
#
# The inclusive lower bound for n in avatar.tags[n] is
# zero. When an animal does a diff of [1] what is run is
# a diff between
#   avatar.tags[0] and avatar.tags[1]
#
# ------------------------------------------------------
