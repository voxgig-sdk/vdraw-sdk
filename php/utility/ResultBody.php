<?php
declare(strict_types=1);

// Vdraw SDK utility: result_body

class VdrawResultBody
{
    public static function call(VdrawContext $ctx): ?VdrawResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
