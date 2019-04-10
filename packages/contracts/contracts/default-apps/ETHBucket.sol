pragma solidity 0.5.7;
pragma experimental "ABIEncoderV2";

import "../interpreters/ETHInterpreter.sol";
import "../interfaces/CounterfactualApp.sol";


contract ETHBucket {

  struct AppState {
    ETHTransferInterpreter.ETHTransfer[] transfers;
  }

  function resolve(bytes calldata encodedState)
    external
    pure
    returns (ETHTransferInterpreter.ETHTransfer[] memory)
  {
    AppState memory state = abi.decode(encodedState, (AppState));

    return state.transfers;
  }

  function resolveSelector()
    external
    pure
    returns (bytes4)
  {
    return this.resolve.selector;
  }


}
