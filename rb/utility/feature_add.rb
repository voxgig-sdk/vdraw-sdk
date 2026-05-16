# Vdraw SDK utility: feature_add
module VdrawUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
