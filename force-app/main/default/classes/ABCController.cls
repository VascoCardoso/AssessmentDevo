public with sharing class ABCController {

    @AuraEnabled(Cacheable=true)
    public static List<ABCController.RecordsWrapper> getRecords(String recordId) {
        Set<Id> bs = new Set<Id>();
        List<ABCController.RecordsWrapper> records = new List<ABCController.RecordsWrapper>();

        for(B__c b : [SELECT Id, Name, BtoA__c FROM B__c WHERE BtoA__c = :recordId WITH SECURITY_ENFORCED]){
            ABCController.RecordsWrapper record = new ABCController.RecordsWrapper();
            bs.add(b.Id);
            record.Id = b.Id;
            record.Name = b.Name;
            records.add(record);
        }

        for(C__c c : [SELECT Id, Name, CtoB__c FROM C__c WHERE CtoB__c In :bs WITH SECURITY_ENFORCED]){
            ABCController.RecordsWrapper record = new ABCController.RecordsWrapper();
            record.Id = c.Id;
            record.Name = c.Name;
            records.add(record);
        }

        return records;
    }

    //Escolhi uma wrapper class para guardar records de objetos diferentes, desta maneira vai tudo direto para um array no js
    public class RecordsWrapper {
        @AuraEnabled public String id;
        @AuraEnabled public String name;
    }
}