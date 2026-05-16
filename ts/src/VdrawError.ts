
import { Context } from './Context'


class VdrawError extends Error {

  isVdrawError = true

  sdk = 'Vdraw'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  VdrawError
}

