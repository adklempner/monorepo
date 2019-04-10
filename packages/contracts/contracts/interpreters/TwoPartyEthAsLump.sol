pragma experimental "ABIEncoderV2";

import "../interfaces/Interpreter.sol";

contract TwoPartyEthAsLump is Interpreter {

  enum Resolution {
    SEND_TO_ADDR_ONE,
    SEND_TO_ADDR_TWO,
    SPLIT_AND_SEND_TO_BOTH_ADDRS
  }

  struct Params {
    address payable[2] playerAddrs;
    uint256 amount;
  }

  function interpret(
    bytes memory encodedResolution, bytes memory encodedParams
  ) public {

    Params memory params = abi.decode(encodedParams, (Params));
    Resolution resolution = abi.decode(encodedResolution, (Resolution));

    if (resolution == Resolution.SEND_TO_ADDR_ONE) {
        params.playerAddrs[0].transfer(params.amount);
        return;
    } else if (resolution == Resolution.SEND_TO_ADDR_TWO) {
        params.playerAddrs[1].transfer(params.amount);
        return;
    }

    /* SPLIT_AND_SEND_TO_BOTH_ADDRS or fallback case */

    params.playerAddrs[0].transfer(params.amount / 2);
    params.playerAddrs[1].transfer(params.amount - params.amount / 2);

    return;
  }
}