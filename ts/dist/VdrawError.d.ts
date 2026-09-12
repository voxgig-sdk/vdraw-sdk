import { Context } from './Context';
declare class VdrawError extends Error {
    isVdrawError: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { VdrawError };
