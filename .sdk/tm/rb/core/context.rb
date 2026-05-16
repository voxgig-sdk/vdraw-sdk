# Vdraw SDK context

require_relative '../utility/struct/voxgig_struct'
require_relative 'control'
require_relative 'operation'
require_relative 'spec'
require_relative 'result'
require_relative 'response'
require_relative 'error'
require_relative 'helpers'

class VdrawContext
  attr_accessor :id, :out, :client, :utility, :ctrl, :meta, :config,
                :entopts, :options, :entity, :shared, :opmap,
                :data, :reqdata, :match, :reqmatch, :point,
                :spec, :result, :response, :op

  def initialize(ctxmap = {}, basectx = nil)
    ctxmap ||= {}
    @id = "C#{rand(10000000..99999999)}"
    @out = {}

    @client = VdrawHelpers.get_ctx_prop(ctxmap, "client") || basectx&.client
    @utility = VdrawHelpers.get_ctx_prop(ctxmap, "utility") || basectx&.utility

    @ctrl = VdrawControl.new
    ctrl_raw = VdrawHelpers.get_ctx_prop(ctxmap, "ctrl")
    if ctrl_raw.is_a?(Hash)
      @ctrl.throw_err = ctrl_raw["throw"] if ctrl_raw.key?("throw")
      @ctrl.explain = ctrl_raw["explain"] if ctrl_raw["explain"].is_a?(Hash)
    elsif basectx&.ctrl
      @ctrl = basectx.ctrl
    end

    m = VdrawHelpers.get_ctx_prop(ctxmap, "meta")
    @meta = m.is_a?(Hash) ? m : (basectx&.meta || {})

    cfg = VdrawHelpers.get_ctx_prop(ctxmap, "config")
    @config = cfg.is_a?(Hash) ? cfg : basectx&.config

    eo = VdrawHelpers.get_ctx_prop(ctxmap, "entopts")
    @entopts = eo.is_a?(Hash) ? eo : basectx&.entopts

    o = VdrawHelpers.get_ctx_prop(ctxmap, "options")
    @options = o.is_a?(Hash) ? o : basectx&.options

    e = VdrawHelpers.get_ctx_prop(ctxmap, "entity")
    @entity = e || basectx&.entity

    s = VdrawHelpers.get_ctx_prop(ctxmap, "shared")
    @shared = s.is_a?(Hash) ? s : basectx&.shared

    om = VdrawHelpers.get_ctx_prop(ctxmap, "opmap")
    @opmap = om.is_a?(Hash) ? om : (basectx&.opmap || {})

    @data = VdrawHelpers.to_map(VdrawHelpers.get_ctx_prop(ctxmap, "data")) || {}
    @reqdata = VdrawHelpers.to_map(VdrawHelpers.get_ctx_prop(ctxmap, "reqdata")) || {}
    @match = VdrawHelpers.to_map(VdrawHelpers.get_ctx_prop(ctxmap, "match")) || {}
    @reqmatch = VdrawHelpers.to_map(VdrawHelpers.get_ctx_prop(ctxmap, "reqmatch")) || {}

    pt = VdrawHelpers.get_ctx_prop(ctxmap, "point")
    @point = pt.is_a?(Hash) ? pt : basectx&.point

    sp = VdrawHelpers.get_ctx_prop(ctxmap, "spec")
    @spec = sp.is_a?(VdrawSpec) ? sp : basectx&.spec

    r = VdrawHelpers.get_ctx_prop(ctxmap, "result")
    @result = r.is_a?(VdrawResult) ? r : basectx&.result

    rp = VdrawHelpers.get_ctx_prop(ctxmap, "response")
    @response = rp.is_a?(VdrawResponse) ? rp : basectx&.response

    opname = VdrawHelpers.get_ctx_prop(ctxmap, "opname") || ""
    @op = resolve_op(opname)
  end

  def resolve_op(opname)
    return @opmap[opname] if @opmap[opname]
    return VdrawOperation.new({}) if opname.empty?

    entname = @entity&.respond_to?(:get_name) ? @entity.get_name : "_"
    opcfg = VoxgigStruct.getpath(@config, "entity.#{entname}.op.#{opname}")

    input = (opname == "update" || opname == "create") ? "data" : "match"

    points = []
    if opcfg.is_a?(Hash)
      t = VoxgigStruct.getprop(opcfg, "points")
      points = t if t.is_a?(Array)
    end

    op = VdrawOperation.new({
      "entity" => entname,
      "name" => opname,
      "input" => input,
      "points" => points,
    })
    @opmap[opname] = op
    op
  end

  def make_error(code, msg)
    VdrawError.new(code, msg, self)
  end
end
