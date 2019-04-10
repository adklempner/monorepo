pragma solidity 0.5.7;
pragma experimental "ABIEncoderV2";

import "../interfaces/CounterfactualApp.sol";

// there is a counter; player2 can unanimously increment it


contract AppWithAction {

  struct State {
    address player1;
    address player2;
    uint256 counter;
  }

  struct Action {
    uint256 increment;
  }

  function getTurnTaker(bytes memory encodedState, address[] memory /* signingKeys */)
    public
    pure
    returns (address)
  {
    State memory state = abi.decode(encodedState, (State));
    return state.player2;
  }

  function resolve(bytes memory)
    public
    pure
    returns (bytes memory)
  {
    return abi.encode(0);
  }

  function applyAction(bytes memory encodedState, bytes memory encodedAction)
    public
    pure
    returns (bytes memory ret)
  {
    State memory state = abi.decode(encodedState, (State));
    Action memory action = abi.decode(encodedAction, (Action));

    state.counter += action.increment;

    return abi.encode(state);
  }
}
