<?php
declare(strict_types=1);

// Vdraw SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class VdrawFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new VdrawBaseFeature();
            case "test":
                return new VdrawTestFeature();
            default:
                return new VdrawBaseFeature();
        }
    }
}
