
%w(
  external_dir
  output_cleaner
  output_truncater
  name_of_caller
  manifest_property

  dojo
  caches
  language
  languages_rename
  languages
  exercise
  exercises
  avatar
  avatars
  kata
  katas
  sandbox
  tag
).each { |sourcefile| require_relative './' + sourcefile }
