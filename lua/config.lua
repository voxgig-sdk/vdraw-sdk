-- Vdraw SDK configuration

-- Build a fresh, fully materialised config table. Every call rebuilds the
-- whole structure, so prefer require("config_shared") unless you need a
-- private copy you intend to mutate.
local function make_config()
  return {
    main = {
      name = "Vdraw",
    },
    feature = {
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
      },
    },
    options = {
      base = "https://vdraw.ai/api",
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["username_generation"] = {},
      },
    },
    entity = {
      ["username_generation"] = {
        ["fields"] = {
          {
            ["name"] = "suggestions",
            ["type"] = "`$ARRAY`",
          },
          {
            ["name"] = "username",
            ["type"] = "`$STRING`",
          },
          {
            ["name"] = "username_idea",
            ["req"] = true,
            ["type"] = "`$STRING`",
          },
        },
        ["name"] = "username_generation",
        ["op"] = {
          ["create"] = {
            ["input"] = "data",
            ["name"] = "create",
            ["points"] = {
              {
                ["args"] = {},
                ["kind"] = "http",
                ["method"] = "POST",
                ["orig"] = "/username_generate",
                ["parts"] = {
                  "username_generate",
                },
                ["select"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
