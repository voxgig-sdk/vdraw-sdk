<?php
declare(strict_types=1);

// Vdraw SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class VdrawMakeContext
{
    public static function call(array $ctxmap, ?VdrawContext $basectx): VdrawContext
    {
        return new VdrawContext($ctxmap, $basectx);
    }
}
