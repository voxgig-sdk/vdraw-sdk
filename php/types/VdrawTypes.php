<?php
declare(strict_types=1);

// Typed models for the Vdraw SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** UsernameGeneration entity data model. */
class UsernameGeneration
{
    public ?array $suggestion = null;
    public ?string $username = null;
    public string $username_idea;
}

/** Request payload for UsernameGeneration#create. */
class UsernameGenerationCreateData
{
    public ?array $suggestion = null;
    public ?string $username = null;
    public string $username_idea;
}

