import { LightningElement, api, wire } from 'lwc';
import { getRecord } from "lightning/uiRecordApi";
import getRecords from '@salesforce/apex/ABCController.getRecords';



export default class ContentTable extends LightningElement {
    
    @api recordId

    totalRecords = []
    displayRecords = []

    //Ligação à função apex 'getRecords'
    @wire(getRecords, { recordId: '$recordId' })
    handleRecord(resp){
        const data = resp.data;
        if(data){
            this.totalRecords = data.map(item => {
                return {
                    Id: item.id, 
                    Name: item.name
                };
            });
           
        }
    }

    //Retorno dos records
    updateRecHandler(event){
        this.displayRecords=[...event.detail.records]
        console.log(event.detail.records)
    }
}