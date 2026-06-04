# Vdraw SDK

Generate funny Instagram-style usernames for social media content

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About Vdraw API

The Vdraw API provides a small set of tools for generating humorous content aimed at social media use, with its main exposed feature being username generation. The service is hosted at `https://vdraw.ai/api` and is catalogued on [Free Public APIs](https://freepublicapis.com/vdraw-api).

What you get from the API:
- A username-generation endpoint that takes a `text` seed and returns a generated Instagram-style username.
- Endpoint shown in the catalogue: `POST /v1/instagram/username-generate`.

Operational notes: the catalogue page lists CORS as disabled and reports relatively high latency and a non-trivial error rate, so callers should plan for retries and run requests server-side. Authentication and rate-limit details are not published. A community C++ wrapper exists at [l0v3m0n3y/Vdraw](https://github.com/l0v3m0n3y/Vdraw).

## Try it

**TypeScript**
```bash
npm install vdraw
```

**Python**
```bash
pip install vdraw-sdk
```

**PHP**
```bash
composer require voxgig/vdraw-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/vdraw-sdk/go
```

**Ruby**
```bash
gem install vdraw-sdk
```

**Lua**
```bash
luarocks install vdraw-sdk
```

## 30-second quickstart

### TypeScript

```ts
import { VdrawSDK } from 'vdraw'

const client = new VdrawSDK({})

```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o vdraw-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "vdraw": {
      "command": "/abs/path/to/vdraw-mcp"
    }
  }
}
```

## Entities

The API exposes one entity:

| Entity | Description | API path |
| --- | --- | --- |
| **UsernameGeneration** | Produces a funny social-media-style username from a seed string, via `POST /v1/instagram/username-generate` with a `text` body parameter. | `/username_generate` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from vdraw_sdk import VdrawSDK

client = VdrawSDK({})

```

### PHP

```php
<?php
require_once 'vdraw_sdk.php';

$client = new VdrawSDK([]);

```

### Golang

```go
import sdk "github.com/voxgig-sdk/vdraw-sdk/go"

client := sdk.NewVdrawSDK(map[string]any{})

```

### Ruby

```ruby
require_relative "Vdraw_sdk"

client = VdrawSDK.new({})

```

### Lua

```lua
local sdk = require("vdraw_sdk")

local client = sdk.new({})

```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = VdrawSDK.test()
const result = await client.UsernameGeneration().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = VdrawSDK.test(None, None)
result, err = client.UsernameGeneration(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = VdrawSDK::test(null, null);
[$result, $err] = $client->UsernameGeneration(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.UsernameGeneration(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = VdrawSDK.test(nil, nil)
result, err = client.UsernameGeneration(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:UsernameGeneration(nil):load(
  { id = "test01" }, nil
)
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

## Using the Vdraw API

- Upstream: [https://vdraw.ai](https://vdraw.ai)
- API docs: [https://freepublicapis.com/vdraw-api](https://freepublicapis.com/vdraw-api)

---

Generated from the Vdraw API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
