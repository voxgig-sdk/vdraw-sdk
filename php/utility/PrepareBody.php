<?php
declare(strict_types=1);

// Vdraw SDK utility: prepare_body

class VdrawPrepareBody
{
    public static function call(VdrawContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
