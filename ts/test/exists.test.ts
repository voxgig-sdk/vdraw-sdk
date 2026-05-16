
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { VdrawSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await VdrawSDK.test()
    equal(null !== testsdk, true)
  })

})
