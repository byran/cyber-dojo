  def builder
    GitDiff::GitDiffBuilder.new()
  end

    diff_lines =
    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    source_diff = builder.build(diff, source_lines.split("\n"))
    diff_lines =
    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    source_diff = builder.build(diff, source_lines.split("\n"))
    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    source_diff = builder.build(diff, source_lines.split("\n"))
  test 'diffs 7 lines apart are not merged ' +
       'into contiguous sections in one chunk' do
    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    source_diff = builder.build(diff, source_lines.split("\n"))
    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    source_diff = builder.build(diff, source_lines.split("\n"))

    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    source_diff = builder.build(diff, source_lines.split("\n"))
    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    source_diff = builder.build(diff, source_lines.split("\n"))
    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    source_diff = builder.build(diff, source_lines.split("\n"))
    expected =

    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    actual = builder.build(diff, source_lines.split("\n"))

    assert_equal expected, actual
    expected =

    diff = GitDiff::GitDiffParser.new(diff_lines).parse_one
    actual = builder.build(diff, source_lines.split("\n"))
    assert_equal expected, actual