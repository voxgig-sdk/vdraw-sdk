

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { VdrawSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


loadEnvLocal(__dirname + '/../../../.env.local')


describe('UsernameGenerationEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when VDRAW_TEST_LIVE=TRUE.
  afterEach(liveDelay('VDRAW_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = VdrawSDK.test()
    const ent = testsdk.UsernameGeneration()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.VDRAW_TEST_LIVE
    for (const op of ['create']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'username_generation.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"suggestions":{"a":true,"h":"Suggestions","n":"suggestions","r":false,"sh":"Alternative username suggestions","t":"`$ARRAY`","key$":"suggestions","index$":0},"username":{"a":true,"h":"Username","n":"username","r":false,"sh":"The generated username","t":"`$STRING`","key$":"username","index$":1},"username_idea":{"a":true,"h":"Username Idea","n":"username_idea","r":true,"sh":"The base idea or keyword for generating a username","t":"`$STRING`","key$":"username_idea","index$":2}},"name":"username_generation","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /username_generate","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/username_generate","q":{},"r":{},"s":[{"lit":"username_generate"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"}},"relations":{"ancestors":[]},"key$":"username_generation","name__orig":"username_generation","Name":"UsernameGeneration","name_":"username_generation","name-":"username-generation","NAME":"USERNAME_GENERATION","index$":0}, {"active":true,"entity":"username_generation","key$":"BasicUsernameGenerationFlow","kind":"basic","name":"BasicUsernameGenerationFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"username_generation_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0}]}, 'UsernameGeneration', {"POST /username_generate":{"protocol":"http","operationId":"usernameGenerate","requestBody":{"required":true,"content":{"application/json":{"schema":{"type":"object","required":["username_idea"],"properties":{"username_idea":{"type":"string","description":"The base idea or keyword for generating a username","example":"username_idea","key$":"username_idea"}},"index$":1}}}},"responses":{"200":{"description":"Successfully generated username","content":{"application/json":{"schema":{"type":"object","properties":{"username":{"type":"string","description":"The generated username","key$":"username"},"suggestions":{"type":"array","description":"Alternative username suggestions","items":{"type":"string"},"key$":"suggestions"}},"index$":0},"example":{"username":"funky_username_2026","suggestions":["cool_username_pro","awesome_username_king","epic_username_master"]}}}},"400":{"description":"Bad request - Invalid input parameters","content":{"application/json":{"schema":{"type":"object","properties":{"error":{"type":"string","description":"Error message"},"code":{"type":"string","description":"Error code"},"details":{"type":"string","description":"Additional error details"}},"x-ref":"#/components/schemas/Error"}}}},"500":{"description":"Internal server error","content":{"application/json":{"schema":{"type":"object","properties":{"error":{"type":"string","description":"Error message"},"code":{"type":"string","description":"Error code"},"details":{"type":"string","description":"Additional error details"}},"x-ref":"#/components/schemas/Error"}}}}},"parameters":[],"securitySource":"unspecified"}})
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const username_generation_ref01_ent = client.UsernameGeneration()
    let username_generation_ref01_data = setup.data.new.username_generation['username_generation_ref01']

    username_generation_ref01_data = (await username_generation_ref01_ent.create(username_generation_ref01_data)).data()
    assert(null != username_generation_ref01_data)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/username_generation/UsernameGenerationTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = VdrawSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['username_generation01','username_generation02','username_generation03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'VDRAW_TEST_USERNAME_GENERATION_ENTID': idmap,
    'VDRAW_TEST_LIVE': 'FALSE',
    'VDRAW_TEST_EXPLAIN': 'FALSE',
  })

  idmap = env['VDRAW_TEST_USERNAME_GENERATION_ENTID']

  const live = 'TRUE' === env.VDRAW_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['VDRAW_TEST_USERNAME_GENERATION_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new VdrawSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.VDRAW_TEST_EXPLAIN,
    live,
    transport,
    now: Date.now(),
  }

  return setup
}
  
