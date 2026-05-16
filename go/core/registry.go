package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewUsernameGenerationEntityFunc func(client *VdrawSDK, entopts map[string]any) VdrawEntity

