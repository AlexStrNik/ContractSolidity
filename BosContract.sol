pragma solidity ^0.4.0;

contract Invent {
    
    struct member{
        address adrs;
        uint tockCount;
    }
    
    member project_manager;//руководитель проекта
    member main_constructor;//главный конструктор
    member project_head;//начальник производства
    member tecknical_director;//техническиий директор
    member OMTC_head;//начальник ОМТС
    member comercial_director;//комерческий директор
    
    uint status;
    string tech_order;
    string KDT;
    
    uint16 confirming_points;
    bool confirming_KDT;
    bool expluatation;
    uint prise;
    uint resource;
    uint resPrise = 1000;
    
    event sendToTelegram(address adrs, string sttr, string buttext);
    event order(address toDir, address fromByu);
    event PSItest(string sttr);
    
    function setProject_manager(address adrs) {project_manager.adrs = adrs;}
    function setMain_constructor(address adrs) {main_constructor.adrs = adrs;}
    function setProject_head(address adrs) {project_head.adrs = adrs;}
    function setTecknical_director(address adrs) {tecknical_director.adrs = adrs;}
    function setOMTC_head(address adrs) {OMTC_head.adrs = adrs;}
    function setComercial_director(address adrs) {comercial_director.adrs = adrs;}
    
    function Invent() payable {
        confirming_points = 0;
        confirming_KDT = false;
        project_manager.adrs = msg.sender;//1
        status = 1;
        printStatus();
    }
    
    modifier mainRoles() {
        require(msg.sender == project_manager.adrs ||
                msg.sender == main_constructor.adrs ||
                msg.sender == project_head.adrs ||
                msg.sender == tecknical_director.adrs ||
                msg.sender == OMTC_head.adrs ||
                msg.sender == comercial_director.adrs);
        _;
    }
    
    struct Product{
        string KDT;
        string data;
    }
    
    function printStatus(){
        sendToTelegram(main_constructor.adrs,tech_order,getStatus());
    }
    function getStatus() returns(string s){
        s = status==1? "DTMdeveloping"://разработка кдт
            status==2? "DTMmathshing"://согласование кдт
            status==3? "DTMreworking"://доработка кдт
            status==4? "PutInProduction"://размещен в производство
            status==5? "ReadinessToPSI"://готовность к пси
            status==6? "CarryingPSI"://проведение пси
            status==7? "ConfirmingOfPSIresults"://согласование результатов пси
            status==8? "TrialExploiatation"://опытная эксплуатация
            status==9? "Sertification"://сертификация
            status==10? "SerialProduction"://серийное производство
            status==11? "ProductionIncrease":"none";//увеличение производста
    }
    
    function setTechOrder(string str){//to start
        tech_order = str;
        sendToTelegram(main_constructor.adrs,tech_order,"organizeDev");//3
    }
    
    function organizeDev(string kdt){//by main_ko
        if (main_constructor.adrs != msg.sender) throw;
        KDT = kdt;//4
        main_constructor.tockCount++;
        confirmingKDT();
        status = 2;
        printStatus();
    }
    
    function confirmingKDT() internal {
        status = 2;
        printStatus();
        sendToTelegram(tecknical_director.adrs,KDT,"confirmKDT");//5
        sendToTelegram(project_manager.adrs,KDT,"confirmKDT");
    }
    
    function confirmKDT() mainRoles{
            confirming_points += 1;
            
        if (confirming_points >= 2){ 
            confirming_KDT = true;
            sendToTelegram(project_head.adrs,KDT,"createTrialProduct");//6
            status = 4;
            printStatus();
        }
    }
    
    Product TrialProd;
    function createTrialProduct(string data) {
        if (msg.sender != project_head.adrs) throw;
        TrialProd.KDT = KDT;
        TrialProd.data = data;
        project_head.tockCount++;
        status = 5;
        printStatus();
        PSI(TrialProd);
    }
    
    function PSI(Product p) internal {
        status = 6;
        printStatus();
        PSItest(p.data);
    }
    
    
    uint
 PSItestConfirmed;
    function ConfirmPSItest() mainRoles{
        status = 7;
        printStatus();
        PSItestConfirmed += 1;
        
        if (PSItestConfirmed >= 6){
            expluatation = true;//10
        }
    }
    
    bool OMTS;
    function TimeIsOut() {
        sendToTelegram(project_manager.adrs,TrialProd.data,"reworkKDT");
        sendToTelegram(project_manager.adrs,TrialProd.data,"sertification");
        //sendToTelegram(OMTC_head.adrs,TrialProd.data,"");
        OMTS = true;
        status = 9;
        printStatus();
    }
    
    function reworkKDT(){
        if (msg.sender != project_manager.adrs) throw;
        status = 3;
        printStatus();
        OMTS = false;
        sendToTelegram(main_constructor.adrs,tech_order,"organizeDev");
        
    }
    
    address[16] exporters;
    uint8 exportersCount;
    
    function addExporters(address adrs, uint res) {//1 res = 1 wei
        if (msg.sender != OMTC_head.adrs) throw;
        if (!OMTS) throw;
        if (res>0) OMTC_head.tockCount++;
        exporters[exportersCount] = adrs;
        resource += res;
        exportersCount++;
    }
    
    function getExporters() constant returns(uint){
        return exportersCount;
    }
    
    function sertification(uint _prise){
        if (msg.sender != project_manager.adrs) throw;
        prise = _prise;
        confirmation();
    }
    
    bool serialProduction;
    function confirmation() internal{
        serialProduction = true;
        status = 10;
        printStatus();
    }
    
    function newOrder() payable {
        if(!serialProduction) throw;
        if(resource<resPrise){
            comercial_director.tockCount--;
            msg.sender.transfer(msg.value);
        }
        comercial_director.tockCount++;
        order(comercial_director.adrs, msg.sender);
        project_head.tockCount++;
        removeRes(resPrise);
    }
    function removeRes(uint res) {
        resource -= res;
    }
}
 

