package voxgigvdrawsdk

import (
	"github.com/voxgig-sdk/vdraw-sdk/core"
	"github.com/voxgig-sdk/vdraw-sdk/entity"
	"github.com/voxgig-sdk/vdraw-sdk/feature"
	_ "github.com/voxgig-sdk/vdraw-sdk/utility"
)

// Type aliases preserve external API.
type VdrawSDK = core.VdrawSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type VdrawEntity = core.VdrawEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type VdrawError = core.VdrawError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewUsernameGenerationEntityFunc = func(client *core.VdrawSDK, entopts map[string]any) core.VdrawEntity {
		return entity.NewUsernameGenerationEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewVdrawSDK = core.NewVdrawSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
