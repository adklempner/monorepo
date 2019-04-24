import CounterfactualApp from "@counterfactual/contracts/build/CounterfactualApp.json";
import { AssetType } from "@counterfactual/types";
import { Contract } from "ethers";
import { BaseProvider } from "ethers/providers";
import { BigNumber, defaultAbiCoder } from "ethers/utils";

import { StateChannel } from "../../models";

export async function computeFreeBalanceIncrements(
  stateChannel: StateChannel,
  appInstanceId: string,
  provider: BaseProvider
): Promise<{ [x: string]: BigNumber }> {
  const appInstance = stateChannel.getAppInstance(appInstanceId);

  const appDefinition = new Contract(
    appInstance.appInterface.addr,
    CounterfactualApp.abi,
    provider
  );

  let resolution = await appDefinition.functions.resolve(
    appInstance.encodedLatestState
  );

  /// todo(xuanji)
  /// there used to be a bunch of retry logic here, to handle the case where
  /// the appDefinition contract was deployed recently (and hence the provider
  /// sometimes returning an incorrect definition). This TODO is to handle
  /// that situation.

  console.log("resolution=", resolution, defaultAbiCoder.decode(["uint256"], resolution));

  if (resolution.assetType !== AssetType.ETH) {
    return Promise.reject("Node only supports ETH resolutions at the moment.");
  }

  return resolution.to.reduce(
    (accumulator, currentValue, idx) => ({
      ...accumulator,
      [currentValue]: resolution.value[idx]
    }),
    {}
  );
}

export function getAliceBobMap(
  channel: StateChannel
): { alice: string; bob: string } {
  return {
    alice: channel.multisigOwners[0],
    bob: channel.multisigOwners[1]
  };
}
