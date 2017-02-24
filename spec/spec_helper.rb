$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))
require 'paudio'

module RSpec

  def self.root
    @spec_root ||= Pathname.new(__dir__)
  end

end
