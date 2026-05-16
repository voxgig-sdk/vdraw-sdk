# Vdraw SDK utility: make_context
require_relative '../core/context'
module VdrawUtilities
  MakeContext = ->(ctxmap, basectx) {
    VdrawContext.new(ctxmap, basectx)
  }
end
