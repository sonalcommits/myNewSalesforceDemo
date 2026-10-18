import { LightningElement, track } from 'lwc';
import getAccountData from '@salesforce/apex/ImperativeDemo.getAccountData';
export default class ImperativeDemo extends LightningElement {
     columns = [
            { label: 'Name', fieldName: 'Name' },
            { label: 'Record Id', fieldName: 'Id' },
            { label: 'Phone', fieldName: 'Phone' }
        ];
        isDataRetrived = false;

        @track data = [];

        handleClick()
        {
            getAccountData()
            .then(result =>{
                this.data = result;
                this.isDataRetrived = true
            })
            .catch(error =>{
                console.log('error occured '+ error);
            })
        }
        handleClearData()
        {
            this.data = [];
            this.isDataRetrived = false;
        }
        
        }