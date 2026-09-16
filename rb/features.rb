# Vdraw SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module VdrawFeatures
  def self.make_feature(name)
    case name
    when "base"
      VdrawBaseFeature.new
    when "ratelimit"
      VdrawRatelimitFeature.new
    when "retry"
      VdrawRetryFeature.new
    when "test"
      VdrawTestFeature.new
    when "timeout"
      VdrawTimeoutFeature.new
    else
      VdrawBaseFeature.new
    end
  end
end
