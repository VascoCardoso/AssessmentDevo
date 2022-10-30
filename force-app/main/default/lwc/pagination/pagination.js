import { LightningElement, api } from 'lwc';

export default class Pagination extends LightningElement {

    totalRecords

    //Variável que dita o nr de records por página
    @api recordSize = 2

    totalPage = 0
    currentPage = 1

    get records(){
        return this.displayRecords
    }


    @api 
    set records(data){
        if(data){ 
            this.totalRecords = data
            this.recordSize = Number(this.recordSize)
            this.totalPage = Math.ceil(data.length/this.recordSize)
            this.updateRecords()
        }
    }

    //Atualização dos records por página
    updateRecords(){ 
        const start = (this.currentPage-1)*this.recordSize
        const end = this.recordSize*this.currentPage
        this.displayRecords = this.totalRecords.slice(start, end)
        this.dispatchEvent(new CustomEvent('update',{ 
            detail:{ 
                records:this.displayRecords
            }
        }))
    }

    //Handler dos botões
    previousHandler(){ 
        if(this.currentPage>1){
            this.currentPage = this.currentPage-1
            this.updateRecords()
        }
    }
    nextHandler(){
        if(this.currentPage < this.totalPage){
            this.currentPage = this.currentPage+1
            this.updateRecords()
        }
    }
}