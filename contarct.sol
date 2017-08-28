pragma solidity ^0.4.0;


contract contact {
    address rukovod;
    string name;
    string TZ;
    string KTD;
    mapping(address=>uint) KTDconf;
    event sendTz(string member);
    event sendKTD(string memeber);
    event checkKTD(mapping(address=>uint) conf);
    mapping(string=>address) members;
    mapping(address=>string) membersr;
    mapping(address=>uint) roles;
    mapping(uint=>address) rolesr;
    function contact(address owner,string nam){// punkt 1
        rukovod=owner;
        name=nam;
    }
    function addMember(address ad, string telenik, uint type ){//0-gk 1-np 2-td 3-nOMTC 4-kd  //add members TODO func available only for rukovod
        members[telenik]=ad;
        membersr[ad]=telenik;
        roles[ad]=type;
        rolesr[type]=ad;
    }
    function onKTDConfirmed(){//punkt 6 TODO func available only for botUser
        sendKTD(rolesr[1]);
    }
    function sendTZ(string tz){// punkt 3 TODO func available only for rukovod
        TZ=tz;
        sendTz(rolesr[0]);
    }
    function addKTD(string ktd){// punkt 4 TODO func available only for rolesr[0]
        KTD=ktd;
    }
    function confirmKTD(string user){// punkt 5 TODO members[user]==msg.sender
        KTDconf[members[user]]=1;
    }
    function isKTDconf() constant returns (uint b){// punkt 5
        checKTD(KTDconf);
    }
}
contract contactFactory{
    function contractFactory(){

    }
    function newProject(string name) returns (address projectAddr){
        projectAddr=new contact(msg.sender,name);

    }
}