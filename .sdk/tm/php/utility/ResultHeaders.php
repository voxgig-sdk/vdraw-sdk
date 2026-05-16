<?php
declare(strict_types=1);

// Vdraw SDK utility: result_headers

class VdrawResultHeaders
{
    public static function call(VdrawContext $ctx): ?VdrawResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
