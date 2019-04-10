import { AppInterface, ETHBucketAppState } from "@counterfactual/types";
import { defaultAbiCoder } from "ethers/utils";

// FIXME: Use this when it returns named version.
// export const freeBalanceStateEncoding = formatParamType(
//   new Interface(ETHBucket.abi).functions.resolve.inputs[0]
// );
const ethBucketStateEncoding = `
  tuple(
    address alice,
    address bob,
    uint256 aliceBalance,
    uint256 bobBalance
  )
`;

export function getETHBucketAppInterface(addr: string): AppInterface {
  return {
    addr,
    stateEncoding: ethBucketStateEncoding,
    actionEncoding: undefined // because no actions exist for ETHBucket
  };
}

export function encodeETHBucketAppState(state: ETHBucketAppState) {
  return defaultAbiCoder.encode([ethBucketStateEncoding], [state]);
}
