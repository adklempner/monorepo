pragma solidity 0.5.7;
pragma experimental "ABIEncoderV2";

import "../interpreters/ETHInterpreter.sol";
import "../interfaces/CounterfactualApp.sol";


contract ETHBalanceRefundApp {

  struct AppState {
    address recipient;
    address multisig;
    uint256 threshold;
  }

  function resolve(bytes memory encodedState)
    public
    view
    returns (ETHTransferInterpreter.ETHTransfer[] memory)
  {
    AppState memory appState = abi.decode(encodedState, (AppState));

    ETHTransferInterpreter.ETHTransfer[] memory ret =
      new ETHTransferInterpreter.ETHTransfer[](0);
    ret[0].amount = address(appState.multisig).balance - appState.threshold;
    ret[0].to = appState.recipient;

    return ret;
  }

  function resolveSelector()
    external
    pure
    returns (bytes4)
  {
    return this.resolve.selector;
  }

}
