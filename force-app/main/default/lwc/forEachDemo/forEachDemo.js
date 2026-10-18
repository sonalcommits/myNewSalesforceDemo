import { LightningElement, track, wire } from 'lwc';
import getContactNames from '@salesforce/apex/forEachLoopDemoClass.getContactNames';

export default class ForEachDemo extends LightningElement {
    @track dataToDisplay = [];
    @wire(getContactNames)
    wiredContacts({data, error})
    {
        if(data)
        {
            this.dataToDisplay = data;
        }
        else if(error)
        {
            console.log('error Occured');
        }
    }
}