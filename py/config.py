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
            "active": True,
            "name": "suggestion",
            "req": False,
            "type": "`$ARRAY`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "username",
            "req": False,
            "type": "`$STRING`",
            "index$": 1,
          },
          {
            "active": True,
            "name": "username_idea",
            "req": True,
            "type": "`$STRING`",
            "index$": 2,
          },
        ],
        "name": "username_generation",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/username_generate",
                "parts": [
                  "username_generate",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
