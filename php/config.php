<?php
declare(strict_types=1);

// Vdraw SDK configuration

class VdrawConfig
{
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "Vdraw",
            ],
            "feature" => [
                "test" => [
          'options' => [
            'active' => false,
          ],
        ],
            ],
            "options" => [
                "base" => "https://vdraw.ai/api",
                "auth" => [
                    "prefix" => "Bearer",
                ],
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "username_generation" => [],
                ],
            ],
            "entity" => [
        'username_generation' => [
          'fields' => [
            [
              'active' => true,
              'name' => 'suggestion',
              'req' => false,
              'type' => '`$ARRAY`',
              'index$' => 0,
            ],
            [
              'active' => true,
              'name' => 'username',
              'req' => false,
              'type' => '`$STRING`',
              'index$' => 1,
            ],
            [
              'active' => true,
              'name' => 'username_idea',
              'req' => true,
              'type' => '`$STRING`',
              'index$' => 2,
            ],
          ],
          'name' => 'username_generation',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'active' => true,
                  'args' => [],
                  'method' => 'POST',
                  'orig' => '/username_generate',
                  'parts' => [
                    'username_generate',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'index$' => 0,
                ],
              ],
              'key$' => 'create',
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return VdrawFeatures::make_feature($name);
    }
}
