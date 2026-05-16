-- Vdraw SDK error

local VdrawError = {}
VdrawError.__index = VdrawError


function VdrawError.new(code, msg, ctx)
  local self = setmetatable({}, VdrawError)
  self.is_sdk_error = true
  self.sdk = "Vdraw"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function VdrawError:error()
  return self.msg
end


function VdrawError:__tostring()
  return self.msg
end


return VdrawError
