// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.9;






contract RussianRoulette
{

    address[] players;
    address[] losers;
    uint256 odds;
    uint256 playersTurn; 
    address creator ;
    uint randNonce = 0;


    constructor()
    {
    creator = msg.sender;
    playersTurn = 0;
    }


    function setOdds (uint256 oneInThisMany) public 
    {
        require(msg.sender == creator, "Only creator can use this method");
        odds = oneInThisMany;
       
    }
    
    
 

    
    function play() public returns(string memory)
    {
        for(; playersTurn < players.length; playersTurn++)
        {
         uint odd = randMod(odds);
        if(odd == 1)
        {
            lose(players[playersTurn]);
            return "You Lost. Player list has been cleared. You may not play again";
        }
        }
    return "Everyone has survived";
    }
    
    
    function lose(address loser) internal 
    {
        losers.push(loser);
        delete players;
    }
   
   
    function addPlayer(address potentialPlayer) public
    {
        require(isALoser(potentialPlayer) == false, "You cannot play because you've lost");
        require(isPlaying(potentialPlayer) == false, "You are already playing the game");
        players.push(potentialPlayer);
        
    }
    
    
    function randMod(uint uBounds) internal returns(uint)
    {
        randNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % uBounds;
    }
    
    
    function isPlaying(address potentialPlayer) internal view returns(bool)
    {
        for(uint i = 0; i < players.length; i++)
        {
            if(potentialPlayer == players[i])
            {
                return true;  
            }
        }
        return false;
    }
    
    
    function isALoser(address potentialLoser) public view returns (bool)
    {
        for(uint i = 0; i < losers.length; i++)
        {
            if(potentialLoser == losers[i])
            {
                return true;  
            }
        }
        return false;
    }
    

}