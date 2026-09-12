import { VdrawEntityBase } from '../VdrawEntityBase';
import type { VdrawSDK } from '../VdrawSDK';
import type { Control } from '../types';
import type { UsernameGeneration, UsernameGenerationCreateData } from '../VdrawTypes';
declare class UsernameGenerationEntity extends VdrawEntityBase<UsernameGeneration> {
    constructor(client: VdrawSDK, entopts: any);
    make(this: UsernameGenerationEntity): UsernameGenerationEntity;
    create(this: any, reqdata?: UsernameGenerationCreateData, ctrl?: Control): Promise<UsernameGenerationEntity>;
}
export { UsernameGenerationEntity };
