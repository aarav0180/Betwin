


/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TransferContract is ERC20 {
    address payable public owner;
    event initsuccess(string roomID , uint amount);
    // string private Secret = "S3CR3T"  ;

    mapping (string => address[2]) Room;
    mapping ( address => uint) bet;
    constructor() ERC20("DeGenCoin", "DGC")  payable  {
        owner = payable(address(this));
    }

    function deposit() public  payable {
        _mint(msg.sender,( (msg.value * 10**6 ) ) );
    }

    function getBalance() internal  view returns (uint256) {
        return address(this).balance;
    }
    function WithdrawCoin(address payable _to, uint val ) public payable {
        _burn(_to, val *(10**(uint(decimals()))));
        (bool sent,) = _to.call{value: ((val)*((10**(uint(decimals())))/(10**6)))}("");
        require(sent, "Failed to send Ether");
    }
    function receiveFunds(address sender,uint val,string calldata roomID,uint pos) external  {
        require(val>10, "Bet needs more than 10 Coin" );
        _transfer(sender, address(this), val);
        bet[sender] = val;
        Room[roomID][pos] = sender;
    }
    function gameStart(string calldata RoomID) public {
        require( (Room[RoomID][0]!=address(0)) && (Room[RoomID][1]!=address(0)),"give an actual roomID");
        require(bet[Room[RoomID][0]] > 10 && bet[Room[RoomID][1]] > 10, "insufficient funds");
        emit initsuccess(RoomID,((bet[Room[RoomID][0]]+bet[Room[RoomID][1]])*9)/10);
    }
    function gameEnd(uint pos,string calldata RoomID) public  {
        if (pos==2) {
            _transfer(address(this), Room[RoomID][0],((bet[Room[RoomID][0]])*9)/10 );
            _transfer(address(this), Room[RoomID][1],((bet[Room[RoomID][1]])*9)/10 );
            Room[RoomID][0] = address(0);
            Room[RoomID][1] = address(0);
            bet[Room[RoomID][0]] = 0;
            bet[Room[RoomID][1]] = 0;
        } else {


            _transfer(address(this), Room[RoomID][pos],((bet[Room[RoomID][0]]+bet[Room[RoomID][1]])*9)/10 );
            Room[RoomID][0] = address(0);
            Room[RoomID][1] = address(0);
            bet[Room[RoomID][0]] = 0;
            bet[Room[RoomID][1]] = 0;
        }
    }
}
