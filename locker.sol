pragma solidity ^0.4.11;

import './QuasacoinToken.sol';

contract QuasacoinTokenLocker {
    address internal quasacoinTokenAddress;

    address internal owner1Address;
    address internal owner2Address;

    function QuasacoinTokenLocker(address _quasacoinTokenAddress,  address _owner1Address, address _owner2Address) public {
        quasacoinTokenAddress = _quasacoinTokenAddress;
        owner1Address = _owner1Address;
        owner2Address = _owner2Address;
    }

    address internal mintUnlockedBy;
    uint internal mintUnlockedAmmount;
    address internal mintUnlockedTo;
    function proposeMint(address _to, uint _ammount) public {
        require(msg.sender == owner1Address || msg.sender == owner2Address);
        
        mintUnlockedBy = msg.sender;
        mintUnlockedTo = _to;
        mintUnlockedAmmount = _ammount;
    }

    function confirmMint(address _to, uint _ammount) public {
        require(msg.sender == owner1Address || msg.sender == owner2Address);
        require(_ammount == mintUnlockedAmmount);
        require(mintUnlockedBy != 0x0 && mintUnlockedBy != msg.sender);

        mintUnlockedBy = 0x0;
        mintUnlockedAmmount=0;
        mintUnlockedTo = 0x0;

        QuasacoinToken c = QuasacoinToken(quasacoinTokenAddress);
        c.mint(_to, _ammount);
    }


    address internal finishMintingUnlockedBy;
    function proposeFinishMinting() public {
        require(msg.sender == owner1Address || msg.sender == owner2Address);
        
        finishMintingUnlockedBy = msg.sender;
    }

    function confirmFinishMinting() public {
        require(msg.sender == owner1Address || msg.sender == owner2Address);
        require(finishMintingUnlockedBy != 0x0 && finishMintingUnlockedBy != msg.sender);

        finishMintingUnlockedBy = 0x0;

        QuasacoinToken c = QuasacoinToken(quasacoinTokenAddress);
        c.finishMinting();
    }

    address internal changeOwnerUnlockedBy;
    address internal newOwnerUnlocked;
    
    function proposeChangeOwner(address _owner) public {
        require(msg.sender == owner1Address || msg.sender == owner2Address);
        
        changeOwnerUnlockedBy = msg.sender;
        newOwnerUnlocked = _owner;
    }

    function confirmChangeOwner(address _owner) public {
        require(msg.sender == owner1Address || msg.sender == owner2Address);
        require(newOwnerUnlocked == _owner);
        require(changeOwnerUnlockedBy != 0x0 && changeOwnerUnlockedBy != msg.sender);

        newOwnerUnlocked = 0x0;
        changeOwnerUnlockedBy = 0x0;

        QuasacoinToken c = QuasacoinToken(quasacoinTokenAddress);
        c.transferOwnership(_owner);
    }


}