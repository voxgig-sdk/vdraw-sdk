# Vdraw SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module VdrawFeatures
  def self.make_feature(name)
    case name
    when "base"
      VdrawBaseFeature.new
    when "test"
      VdrawTestFeature.new
    else
      VdrawBaseFeature.new
    end
  end
end
