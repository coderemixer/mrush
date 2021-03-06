MRuby::Build.new do |conf|
  # load specific toolchain settings

  # Gets set by the VS command prompts.
  if ENV['MRUBY_TOOLCHAIN']
    toolchain ENV['MRUBY_TOOLCHAIN']
  elsif ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  # use mrbgems
  Dir.glob("../mruby-*/mrbgem.rake") do |x|
    g = File.basename File.dirname x
    conf.gem "../thirdparty/gems/#{g}"
  end

  # include all the core GEMs
  conf.gembox 'full-core'

  # load addtional dependency definition if exists
  if ENV['MRUBY_ADDITIONAL_CONFIG'] && File.exist?(ENV['MRUBY_ADDITIONAL_CONFIG'])
    path = ENV['MRUBY_ADDITIONAL_CONFIG']
    eval File.open(path){|f| f.read }, binding, path
  end
end