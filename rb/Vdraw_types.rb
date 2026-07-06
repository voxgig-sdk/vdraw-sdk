# frozen_string_literal: true

# Typed models for the Vdraw SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# UsernameGeneration entity data model.
#
# @!attribute [rw] suggestion
#   @return [Array, nil]
#
# @!attribute [rw] username
#   @return [String, nil]
#
# @!attribute [rw] username_idea
#   @return [String]
UsernameGeneration = Struct.new(
  :suggestion,
  :username,
  :username_idea,
  keyword_init: true
)

# Request payload for UsernameGeneration#create.
#
# @!attribute [rw] suggestion
#   @return [Array, nil]
#
# @!attribute [rw] username
#   @return [String, nil]
#
# @!attribute [rw] username_idea
#   @return [String]
UsernameGenerationCreateData = Struct.new(
  :suggestion,
  :username,
  :username_idea,
  keyword_init: true
)

