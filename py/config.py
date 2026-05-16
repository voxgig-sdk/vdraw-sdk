# Vdraw SDK configuration


def make_config():
    return {
        "main": {
            "name": "Vdraw",
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
      },
        },
        "options": {
            "base": "https://vdraw.ai/api",
            "auth": {
                "prefix": "Bearer",
            },
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "username_generation": {},
            },
        },
        "entity": {
      "username_generation": {
        "fields": [
          {
            "name": "suggestion",
            "req": False,
            "type": "`$ARRAY`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "username",
            "req": False,
            "type": "`$STRING`",
            "active": True,
            "index$": 1,
          },
          {
            "name": "username_idea",
            "req": True,
            "type": "`$STRING`",
            "active": True,
            "index$": 2,
          },
        ],
        "name": "username_generation",
        "op": {
          "create": {
            "name": "create",
            "points": [
              {
                "method": "POST",
                "orig": "/username_generate",
                "parts": [
                  "username_generate",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
