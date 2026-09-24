
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { VdrawSDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = VdrawSDK.test()
    equal(testsdk instanceof VdrawSDK, true,
      'VdrawSDK.test() must return a client synchronously')
  })

})
