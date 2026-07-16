<?php
declare(strict_types=1);

// Vdraw SDK base feature

class VdrawBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(VdrawContext $ctx, array $options): void {}
    public function PostConstruct(VdrawContext $ctx): void {}
    public function PostConstructEntity(VdrawContext $ctx): void {}
    public function SetData(VdrawContext $ctx): void {}
    public function GetData(VdrawContext $ctx): void {}
    public function GetMatch(VdrawContext $ctx): void {}
    public function SetMatch(VdrawContext $ctx): void {}
    public function PrePoint(VdrawContext $ctx): void {}
    public function PreSpec(VdrawContext $ctx): void {}
    public function PreRequest(VdrawContext $ctx): void {}
    public function PreResponse(VdrawContext $ctx): void {}
    public function PreResult(VdrawContext $ctx): void {}
    public function PreDone(VdrawContext $ctx): void {}
    public function PreUnexpected(VdrawContext $ctx): void {}
}
