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
              'name' => 'suggestion',
              'req' => false,
              'type' => '`$ARRAY`',
              'active' => true,
              'index$' => 0,
            ],
            [
              'name' => 'username',
              'req' => false,
              'type' => '`$STRING`',
              'active' => true,
              'index$' => 1,
            ],
            [
              'name' => 'username_idea',
              'req' => true,
              'type' => '`$STRING`',
              'active' => true,
              'index$' => 2,
            ],
          ],
          'name' => 'username_generation',
          'op' => [
            'create' => [
              'name' => 'create',
              'points' => [
                [
                  'method' => 'POST',
                  'orig' => '/username_generate',
                  'parts' => [
                    'username_generate',
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'active' => true,
                  'args' => [],
                  'select' => [],
                  'index$' => 0,
                ],
              ],
              'input' => 'data',
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
