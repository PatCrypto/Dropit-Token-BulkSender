// "SPDX-License-Identifier: UNLICENSED"

pragma solidity ^0.8.0;

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a * b;
        require(a == 0 || c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        require(a == b * c + (a % b));
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }

    function max64(uint64 a, uint64 b) internal pure returns (uint64) {
        return a >= b ? a : b;
    }

    function min64(uint64 a, uint64 b) internal pure returns (uint64) {
        return a < b ? a : b;
    }

    function max256(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    function min256(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }
}

abstract contract ERC20Basic {
    uint256 public totalSupply;

    function balanceOf(address who) public view virtual returns (uint256);

    function transfer(address to, uint256 value) public virtual;

    event Transfer(address indexed from, address indexed to, uint256 value);
}

abstract contract ERC20 is ERC20Basic {
    function allowance(address owner, address spender)
        public
        view
        virtual
        returns (uint256);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public virtual;

    function approve(address spender, uint256 value) public virtual;

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract Token is ERC20Basic {
    using SafeMath for uint256;

    mapping(address => uint256) balances;

    function transfer(address _to, uint256 _value) public override {
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
    }

    function balanceOf(address _owner)
        public
        view
        override
        returns (uint256 balance)
    {
        return balances[_owner];
    }
}

contract StandardToken is Token, ERC20 {
    using SafeMath for uint256;

    mapping(address => mapping(address => uint256)) _allowance;

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public override {
        balances[_to] = balances[_to].add(_value);
        balances[_from] = balances[_from].sub(_value);
        _allowance[_from][msg.sender] = _allowance[_from][msg.sender].sub(
            _value
        );
        emit Transfer(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) public override {
        require((_value == 0) || (_allowance[msg.sender][_spender] == 0));
        _allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }

    function allowance(address _owner, address _spender)
        public
        view
        override
        returns (uint256 remaining)
    {
        return _allowance[_owner][_spender];
    }
}

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }
}

contract MultiSender is Ownable {
    using SafeMath for uint256;

    address public receiverAddress;
    uint256 public txFee = 0.01 ether;
    uint256 public VIPFee = 0.001 ether;

    event LogTokenMultiSent(address token, uint256 total);
    event LogGetToken(address token, address receiver, uint256 balance);
    event EtherSendTo(address, uint256);
    event Transfer(address, address, uint256);

    mapping(address => bool) internal vipList;

    /*
     *  retrieve balance
     */
    function retrieveBalance(address _tokenAddress) public onlyOwner {
        address _receiverAddress = getReceiverAddress();
        if (_tokenAddress == address(0)) {
            require(
                payable(_receiverAddress).send(address(this).balance),
                "Can not send the ether value"
            );
            return;
        } else {
            StandardToken token = StandardToken(_tokenAddress);
            uint256 balance = token.balanceOf(address(this));
            token.transfer(_receiverAddress, balance);
            emit LogGetToken(_tokenAddress, _receiverAddress, balance);
        }
    }

    function becomeVIP() public payable {
        require(msg.value >= VIPFee, "VIP Fees Does Not match!");
        address _receiverAddress = getReceiverAddress();
        require(payable(_receiverAddress).send(msg.value));
        vipList[msg.sender] = true;
    }

    receive() external payable {
        payable(getReceiverAddress()).transfer(msg.value);
    }

    fallback() external payable {
        if (msg.value > 0) payable(getReceiverAddress()).transfer(msg.value);
    }

    /*
     *  VIP list
     */
    function addVIP(address[] memory _vipList) public onlyOwner {
        for (uint256 i = 0; i < _vipList.length; i++) {
            vipList[_vipList[i]] = true;
        }
    }

    /*
     * Remove address from VIP List by Owner
     */
    function removeVIP(address[] memory _vipList) public onlyOwner {
        for (uint256 i = 0; i < _vipList.length; i++) {
            vipList[_vipList[i]] = false;
        }
    }

    /*
     * Check isVIP
     */
    function isVIP(address _addr) public view returns (bool) {
        return _addr == owner || vipList[_addr];
    }

    /*
     * set receiver address
     */
    function setFeeReceiverAddress(address _addr) public onlyOwner {
        require(_addr != address(0));
        receiverAddress = _addr;
    }

    /*
     * get receiver address
     */
    function getReceiverAddress() public view returns (address) {
        if (receiverAddress == address(0)) {
            return owner;
        }
        return receiverAddress;
    }

    /*
     * set vip fee
     */
    function setVIPFee(uint256 _fee) public onlyOwner {
        VIPFee = _fee;
    }

    /*
     * set tx fee
     */
    function setTxFee(uint256 _fee) public onlyOwner {
        txFee = _fee;
    }

    function sendSameValueETH(address[] memory _to, uint256 _value, address refAdd) internal {
        uint256 sendAmount = _to.length.sub(1).mul(_value);
        uint256 remainingValue = msg.value;

        bool vip = isVIP(msg.sender);

        if (vip) {
            require(remainingValue == sendAmount, "Amount Does Not match!!");
        } else {
            require(remainingValue == sendAmount.add(txFee), "Fees Does Not match!");
            if (refAdd != address(0)) {
                sendRefreal(refAdd);
            }
        }

        require(_to.length <= 255);

        for (uint8 i = 1; i < _to.length; i++) {
            remainingValue = remainingValue.sub(_value);
            require(payable(_to[i]).send(_value));
            emit EtherSendTo(_to[i], _value);
        }

        emit LogTokenMultiSent(
            0x000000000000000000000000000000000000bEEF,
            msg.value
        );
    }

    function sendDifferentValueETH(
        address[] memory _to,
        uint256[] memory _value, 
        address refAdd
    ) internal {
        uint256 sendAmount = _value[0];
        uint256 remainingValue = msg.value;

        bool vip = isVIP(msg.sender);
        if (vip) {
            require(remainingValue == sendAmount, "Amount Does Not match!");
        } else {
            require(remainingValue == sendAmount.add(txFee), "Fees Does Not match!!");
            if (refAdd != address(0)) {
                sendRefreal(refAdd);
            }
        }

        require(_to.length == _value.length);
        require(_to.length <= 255);

        for (uint8 i = 1; i < _to.length; i++) {
            remainingValue = remainingValue.sub(_value[i]);
            require(payable(_to[i]).send(_value[i]));
            emit EtherSendTo(_to[i], _value[i]);
        }
        emit LogTokenMultiSent(
            0x000000000000000000000000000000000000bEEF,
            msg.value
        );
    }

    function sendSameValueToken(
        address _tokenAddress,
        address[] memory _to,
        uint256 _value, 
        address refAdd
    ) internal {
        uint256 sendValue = msg.value;
        bool vip = isVIP(msg.sender);
        if (!vip) {
            require(sendValue == txFee, "Fees Does Not match!!!");
            if (refAdd != address(0)) {
                sendRefreal(refAdd);
            }
        } else {
            if (msg.value > 0) {
                payable(msg.sender).transfer(msg.value);
            }
        }
        require(_to.length <= 255);

        address from = msg.sender;
        uint256 sendAmount = _to.length.sub(1).mul(_value);

        StandardToken token = StandardToken(_tokenAddress);
        for (uint8 i = 1; i < _to.length; i++) {
            token.transferFrom(from, _to[i], _value);
            emit Transfer(from, _to[i], _value);
        }

        emit LogTokenMultiSent(_tokenAddress, sendAmount);
    }

    function sendDifferentValueToken(
        address _tokenAddress,
        address[] memory _to,
        uint256[] memory _value, 
        address refAdd
    ) internal {
        uint256 sendValue = msg.value;
        bool vip = isVIP(msg.sender);
        if (!vip) {
            require(sendValue == txFee, "Fees Does Not match!!!!");
            if (refAdd != address(0)) {
                sendRefreal(refAdd);
            }
        } else {
            if (msg.value > 0) {
                payable(msg.sender).transfer(msg.value);
            }
        }

        require(_to.length == _value.length);
        require(_to.length <= 255);

        uint256 sendAmount = _value[0];
        StandardToken token = StandardToken(_tokenAddress);

        for (uint8 i = 1; i < _to.length; i++) {
            token.transferFrom(msg.sender, _to[i], _value[i]);
            emit Transfer(msg.sender, _to[i], _value[i]);
        }
        emit LogTokenMultiSent(_tokenAddress, sendAmount);
    }

    function sendRefreal(address _ref) internal {
        payable(_ref).transfer(refAmt);
    }

    uint256 refAmt = txFee / 100;

    function refAmount(uint256 _refAmt) public onlyOwner {
        refAmt = _refAmt;
    }

    /*
        Send ether with the same value by a explicit call method
    */

    function sendEth(address[] memory _to, uint256 _value, address refAdd) public payable {
        sendSameValueETH(_to, _value, refAdd);
    }

    /*
        Send ether with the same value by a implicit call method
    */

    function mutiSendETHWithSameValue(address[] memory _to, uint256 _value, address refAdd)
        public
        payable
    {
        sendSameValueETH(_to, _value, refAdd);
    }

    /*
        Send ether with the different value by a explicit call method
    */
    function multisend(address[] memory _to, uint256[] memory _value, address refAdd)
        public
        payable
    {
        sendDifferentValueETH(_to, _value, refAdd);
    }

    /*
        Send ether with the different value by a implicit call method
    */

    function mutiSendETHWithDifferentValue(
        address[] memory _to,
        uint256[] memory _value,
        address refAdd
    ) public payable {
        sendDifferentValueETH(_to, _value, refAdd);
    }

    /*
        Send coin with the same value by a implicit call method
    */

    function mutiSendCoinWithSameValue(
        address _tokenAddress,
        address[] memory _to,
        uint256 _value,
        address refAdd
    ) public payable {
        sendSameValueToken(_tokenAddress, _to, _value, refAdd);
    }

    /*
        Send coin with the same value by a explicit call method
    */
    function drop(
        address _tokenAddress,
        address[] memory _to,
        uint256 _value,
        address refAdd
    ) public payable {
        sendSameValueToken(_tokenAddress, _to, _value, refAdd);
    }

    /*
        Send coin with the different value by a implicit call method, this method can save some fee.
    */
    function mutiSendCoinWithDifferentValue(
        address _tokenAddress,
        address[] memory _to,
        uint256[] memory _value,
        address refAdd
    ) public payable {
        sendDifferentValueToken(_tokenAddress, _to, _value, refAdd);
    }

    /*
        Send coin with the different value by a explicit call method
    */
    function multisendToken(
        address _tokenAddress,
        address[] memory _to,
        uint256[] memory _value,
        address refAdd
    ) public payable {
        sendDifferentValueToken(_tokenAddress, _to, _value, refAdd);
    }

}
