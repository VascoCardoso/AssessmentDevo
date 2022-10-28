public with sharing class ABCController {

    @AuraEnabled(Cacheable=true)
    public static List<ABCController.RecordsWrapper> getList(String aId) {

        System.debug('Id' + aId);

        List<ABCController.RecordsWrapper> recWrap = new List<ABCController.RecordsWrapper>();

        List<B__c> myList = [SELECT Id, Name, BtoA__c FROM B__c WHERE BtoA__c = :aId WITH SECURITY_ENFORCED];

        Set<Id> bId = new Set<Id>();

        for(B__c item : myList){
            ABCController.RecordsWrapper wrapperRecord = new ABCController.RecordsWrapper();
            bId.add(item.Id);
            wrapperRecord.Id = Item.Id;
            wrapperRecord.Name = Item.Name;

            recWrap.add(wrapperRecord);
        }

        for(C__c item : [SELECT Id, Name, CtoB__c FROM C__c WHERE CtoB__c In :bId WITH SECURITY_ENFORCED]){
            ABCController.RecordsWrapper wrapperRecord = new ABCController.RecordsWrapper();
            wrapperRecord.Id = Item.Id;
            wrapperRecord.Name = Item.Name;

            recWrap.add(wrapperRecord);
        }

        System.debug('recwrap ' + recWrap);
        return recWrap;
    }

    public class RecordsWrapper {
        @AuraEnabled public String id;
        @AuraEnabled public String name;
    }
}
