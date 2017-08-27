pragma solidity ^0.4.0;
// created by Andrew
contract qqq {
    mapping (uint => address) InvestAddress;
    mapping (uint => uint) InvestBalance;
    uint InvestsCount;
    mapping (uint => address) FreelanceAddress;
    mapping(uint => uint) FreelanceBalance;
    mapping(uint => uint) FreelanceTockens;
    uint FreelanceCount;
    address owner;
    uint a;
    
    function qqq() payable {
        InvestsCount = 0;
        FreelanceCount = 0;
        owner = msg.sender;
    }
    
    function ToInvest() payable {
        InvestAddress[InvestsCount] = msg.sender;
        InvestBalance[InvestsCount] = msg.value;
        InvestsCount += 1;
    }
    
    function getData() constant returns(uint){
        return(InvestsCount);
    }
    
    function BecomeFreelance(){
        FreelanceAddress[FreelanceCount] = msg.sender;
        FreelanceCount += 1;
    }
    
    
    function AddTockens(address adrs, uint val) {
        uint index = 999;
        for (uint i = 0; i<FreelanceCount; i++ ){
            if (FreelanceAddress[i] == adrs) {
                index = i;
                break;
            }
        }
        FreelanceTockens[index] += val;
    }
    
    function Recount(){
        uint allTockens = 0;
        for (uint i = 0; i<FreelanceCount; i++){
            allTockens += FreelanceTockens[i];
        }
        
        for (uint j = 0; i<FreelanceCount; i++){
            FreelanceBalance[j] = this.balance * FreelanceTockens[j]/allTockens;
        }
        
    }
    
    function getMyBalance() re
    
}
