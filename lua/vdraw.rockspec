package = "voxgig-sdk-vdraw"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/vdraw-sdk.git"
}
description = {
  summary = "Vdraw SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["vdraw_sdk"] = "vdraw_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
