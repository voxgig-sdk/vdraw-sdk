# Vdraw SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

VdrawUtility.registrar = ->(u) {
  u.clean = VdrawUtilities::Clean
  u.done = VdrawUtilities::Done
  u.make_error = VdrawUtilities::MakeError
  u.feature_add = VdrawUtilities::FeatureAdd
  u.feature_hook = VdrawUtilities::FeatureHook
  u.feature_init = VdrawUtilities::FeatureInit
  u.fetcher = VdrawUtilities::Fetcher
  u.make_fetch_def = VdrawUtilities::MakeFetchDef
  u.make_context = VdrawUtilities::MakeContext
  u.make_options = VdrawUtilities::MakeOptions
  u.make_request = VdrawUtilities::MakeRequest
  u.make_response = VdrawUtilities::MakeResponse
  u.make_result = VdrawUtilities::MakeResult
  u.make_point = VdrawUtilities::MakePoint
  u.make_spec = VdrawUtilities::MakeSpec
  u.make_url = VdrawUtilities::MakeUrl
  u.param = VdrawUtilities::Param
  u.prepare_auth = VdrawUtilities::PrepareAuth
  u.prepare_body = VdrawUtilities::PrepareBody
  u.prepare_headers = VdrawUtilities::PrepareHeaders
  u.prepare_method = VdrawUtilities::PrepareMethod
  u.prepare_params = VdrawUtilities::PrepareParams
  u.prepare_path = VdrawUtilities::PreparePath
  u.prepare_query = VdrawUtilities::PrepareQuery
  u.result_basic = VdrawUtilities::ResultBasic
  u.result_body = VdrawUtilities::ResultBody
  u.result_headers = VdrawUtilities::ResultHeaders
  u.transform_request = VdrawUtilities::TransformRequest
  u.transform_response = VdrawUtilities::TransformResponse
}
