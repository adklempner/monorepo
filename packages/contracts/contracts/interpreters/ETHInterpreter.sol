pragma solidity 0.5.7;
pragma experimental "ABIEncoderV2";

contract ETHTransferInterpreter {

  struct ETHTransfer {
    address to;
    uint256 amount;
  }

  struct Param {
    uint256 limit;
  }

  function interpret(
    bytes memory input, bytes memory params
  ) public {

    ETHTransfer[] memory transfers = abi.decode(input, (ETHTransfer[]));
    uint256 limitRemaining = abi.decode(params, (Param)).limit;

    for (uint i=0; i<transfers.length; i++) {
      address payable to = address(uint160(transfers[i].to));
      uint256 amount = transfers[i].amount;

      require(amount <= limitRemaining, "hit the limit");
      limitRemaining -= amount;

      // note: send() is deliberately used instead of transfer() here
      to.send(amount);
    }
  }
}