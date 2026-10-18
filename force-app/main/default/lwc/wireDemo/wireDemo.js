import { LightningElement , track,wire} from 'lwc';
import getAccountData from '@salesforce/apex/WireDemo.getAccountData';
export default class WireDemo extends LightningElement {
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Record Id', fieldName: 'Id' },
        { label: 'Phone', fieldName: 'Phone' }
    ];

    @track data = [];
    @wire(getAccountData)
    wiredAccounts({ data, error }) {
        if (data) {
            this.data = data;
        } else if (error) {
            console.log('Error is '+error);
        }
    }
    
}