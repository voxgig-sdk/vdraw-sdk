<?php
declare(strict_types=1);

// Vdraw SDK utility: feature_add

class VdrawFeatureAdd
{
    public static function call(VdrawContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
