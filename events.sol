pragma solidity ^0.4.0;


contract events {
    event Accepted(
        address indexed who
    );
    function events(){

    }
    function accept(){
        Accepted(msg.sender);
    }
}
