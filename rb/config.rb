# Vdraw SDK configuration

module VdrawConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "Vdraw",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
        },
      },
      "options" => {
        "base" => "https://vdraw.ai/api",
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "username_generation" => {},
        },
      },
      "entity" => {
        "username_generation" => {
          "fields" => [
            {
              "name" => "suggestions",
              "type" => "`$ARRAY`",
            },
            {
              "name" => "username",
              "type" => "`$STRING`",
            },
            {
              "name" => "username_idea",
              "req" => true,
              "type" => "`$STRING`",
            },
          ],
          "name" => "username_generation",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/username_generate",
                  "parts" => [
                    "username_generate",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    VdrawFeatures.make_feature(name)
  end
end
