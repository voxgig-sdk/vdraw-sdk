# Vdraw SDK feature factory

from vdraw_sdk.feature.base_feature import VdrawBaseFeature
from vdraw_sdk.feature.ratelimit_feature import VdrawRatelimitFeature
from vdraw_sdk.feature.retry_feature import VdrawRetryFeature
from vdraw_sdk.feature.test_feature import VdrawTestFeature
from vdraw_sdk.feature.timeout_feature import VdrawTimeoutFeature


_FEATURES = {
    "base": lambda: VdrawBaseFeature(),
    "ratelimit": lambda: VdrawRatelimitFeature(),
    "retry": lambda: VdrawRetryFeature(),
    "test": lambda: VdrawTestFeature(),
    "timeout": lambda: VdrawTimeoutFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
