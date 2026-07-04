# Typed models for the Vdraw SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Any


@dataclass
class UsernameGeneration:
    username_idea: str
    suggestion: Optional[list] = None
    username: Optional[str] = None


@dataclass
class UsernameGenerationCreateData:
    suggestion: Optional[list] = None
    username: Optional[str] = None
    username_idea: Optional[str] = None

