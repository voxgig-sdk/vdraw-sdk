# ProjectName SDK exists test

import pytest
from vdraw_sdk import VdrawSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = VdrawSDK.test(None, None)
        assert testsdk is not None
