pragma solidity 0.5.7;
pragma experimental "ABIEncoderV2";

interface CounterfactualApp {

  function isStateTerminal(bytes calldata)
    external
    pure
    returns (bool);

  function getTurnTaker(bytes calldata, address[] calldata)
    external
    pure
    returns (address);

  function applyAction(bytes calldata, bytes calldata)
    external
    pure
    returns (bytes memory);

  function resolve(bytes calldata)
    external
    pure
    returns (bytes memory);

  function resolveSelector()
    external
    pure
    returns (bytes4);

}
