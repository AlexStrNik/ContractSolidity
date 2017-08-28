pragma solidity ^0.4.0;

contract qqq {
    
    address project_manager;//руководитель проекта
    address main_constructor;//главный конструктор
    address project_head;//начальник производства
    address tecknical_director;//техническиий директор
    address OMTC_head;//начальник ОМТС
    address comercial_director;//комерческий директор
    
    uint status;
    string tech_order;
    string KDT;
    
    uint16 confirming_points;
    bool confirming_KDT;
    bool expluatation;
    uint prise;
    uint resource;
    
    event sendToTelegram(address adrs, string sttr);
    event order(address toDir, address fromByu);
    event PSItest(string sttr);
    
    function qqq() payable {
        confirming_points = 0;
        confirming_KDT = false;
        project_manager = msg.sender;//1
        status = 1;
    }
    
    modifier mainRoles() {
        require(msg.sender == project_manager ||
                msg.sender == main_constructor ||
                msg.sender == project_head ||
                msg.sender == tecknical_director ||
                msg.sender == OMTC_head ||
                msg.sender == comercial_director);
        _;
    }
    
    struct Product{
        string KDT;
        string data;
    }
    
    function getStatus() constant returns(string s){
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
        sendToTelegram(main_constructor,tech_order);//3
    }
    
    function organizeDev(string kdt){//by main_ko
        if (main_constructor != msg.sender) throw;
        KDT = kdt;//4
        confirmingKDT();
    }
    
    function confirmingKDT() internal {
        status = 2;
        sendToTelegram(tecknical_director,KDT);//5
        sendToTelegram(project_manager,KDT);
    }
    
    function confirmKDT() mainRoles{
            confirming_points += 1;
            
        if (confirming_points >= 2){ 
            confirming_KDT = true;
            sendToTelegram(project_head,KDT);//6
        }
    }
    
    Product TrialProd;
    function CreateTrialProduct(string data) {
        if (msg.sender != project_head) throw;
        TrialProd.KDT = KDT;
        TrialProd.data = data;
        status = 5;
        PSI(TrialProd);
    }
    
    function PSI(Product p) internal {
        status = 6;
        PSItest(p.data);
    }
    
    
    uint PSItestConfirmed;
    function ConfirmPSItest() mainRoles{
        PSItestConfirmed += 1;
        
        if (PSItestConfirmed >= 6){
            expluatation = true;//10
        }
    }
    
    function TimeIsOut() {
        sendToTelegram(project_manager,TrialProd.data);
        sendToTelegram(OMTC_head,TrialProd.data);
        status = 9;
    }
    
    function ReworkKDT(){
        if (msg.sender != project_manager) throw;
        sendToTelegram(main_constructor,tech_order);
        
    }
    
    address[16] exporters;
    uint8 exportersCount;
    
    function addExporters(address adrs,uint res) {//1 res = 1 wei
        if (msg.sender != OMTC_head) throw;
        tra
        exporters[exportersCount] = adrs;
        resource += res;
        exportersCount++;
    }
    
    function getExporters() constant returns(uint){
        return exportersCount;
    }
    
    function sertification(uint _prise){
        if (msg.sender != project_manager) throw;
        prise = _prise;
        confirmation();
    }
    
    function confirmation
 () internal{
        sendToTelegram(comercial_director,"sertificationEnded");
        status = 10;
    }
    
    
    function newOrder() payable {
        order(comercial_director, msg.sender);
    }
    function removeRes(uint res) {
        resource -= res;
    }
    
    
    
}
