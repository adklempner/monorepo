pragma solidity 0.5.7;
pragma experimental "ABIEncoderV2";

// todo: adding is CounterfactualApp makes empty bytecode...

/// @title ResolveToPay5WeiApp
/// @notice This contract is a test fixture meant to emulate an AppInstance
/// contract. An AppInstance has a resolve() function that returns a
/// `Transfer.Transaction` object when the channel is closed.
contract ResolveToPay5WeiApp {

  function resolve(bytes calldata)
    external
    pure
    returns (uint256)
  {
    return 500;
  }

  function resolveSelector()
    external
    pure
    returns (bytes4)
  {
    return this.resolve.selector;
  }


}
