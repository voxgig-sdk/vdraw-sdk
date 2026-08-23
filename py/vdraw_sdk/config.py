# Vdraw SDK configuration


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "Vdraw",
            "slug": "vdraw",
            "version": "0.0.1",
            "target": "py",
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
            "name": "suggestions",
            "short": "Alternative username suggestions",
            "type": "`$ARRAY`",
          },
          {
            "name": "username",
            "short": "The generated username",
            "type": "`$STRING`",
          },
          {
            "name": "username_idea",
            "req": True,
            "short": "The base idea or keyword for generating a username",
            "type": "`$STRING`",
          },
        ],
        "name": "username_generation",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "args": {},
                "kind": "http",
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
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
