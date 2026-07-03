package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/vdraw-sdk/go"
	"github.com/voxgig-sdk/vdraw-sdk/go/core"

	vs "github.com/voxgig-sdk/vdraw-sdk/go/utility/struct"
)

func TestUsernameGenerationEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.UsernameGeneration(nil)
		if ent == nil {
			t.Fatal("expected non-nil UsernameGenerationEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := username_generationBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"create"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "username_generation." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set VDRAW_TEST_USERNAME_GENERATION_ENTID JSON to run live")
			return
		}
		client := setup.client

		// CREATE
		usernameGenerationRef01Ent := client.UsernameGeneration(nil)
		usernameGenerationRef01Data := core.ToMapAny(vs.GetProp(
			vs.GetPath([]any{"new", "username_generation"}, setup.data), "username_generation_ref01"))

		usernameGenerationRef01DataResult, err := usernameGenerationRef01Ent.Create(usernameGenerationRef01Data, nil)
		if err != nil {
			t.Fatalf("create failed: %v", err)
		}
		usernameGenerationRef01Data = core.ToMapAny(usernameGenerationRef01DataResult)
		if usernameGenerationRef01Data == nil {
			t.Fatal("expected create result to be a map")
		}

	})
}

func username_generationBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "username_generation", "UsernameGenerationTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read username_generation test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse username_generation test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"username_generation01", "username_generation02", "username_generation03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("VDRAW_TEST_USERNAME_GENERATION_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"VDRAW_TEST_USERNAME_GENERATION_ENTID": idmap,
		"VDRAW_TEST_LIVE":      "FALSE",
		"VDRAW_TEST_EXPLAIN":   "FALSE",
		"VDRAW_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["VDRAW_TEST_USERNAME_GENERATION_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["VDRAW_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["VDRAW_APIKEY"],
			},
			extra,
		})
		client = sdk.NewVdrawSDK(core.ToMapAny(mergedOpts))
	}

	live := env["VDRAW_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["VDRAW_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
