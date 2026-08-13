# Vdraw SDK feature factory

from vdraw_sdk.feature.base_feature import VdrawBaseFeature
from vdraw_sdk.feature.test_feature import VdrawTestFeature


def _make_feature(name):
    features = {
        "base": lambda: VdrawBaseFeature(),
        "test": lambda: VdrawTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
