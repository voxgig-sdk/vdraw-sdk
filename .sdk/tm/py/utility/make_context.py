# Vdraw SDK utility: make_context

from core.context import VdrawContext


def make_context_util(ctxmap, basectx):
    return VdrawContext(ctxmap, basectx)
