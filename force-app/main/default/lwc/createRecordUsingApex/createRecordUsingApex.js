import CreateAccRecord from '@salesforce/apex/CreateAccRecordFromLWC.CreateAccRecord';
import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Title from '@salesforce/schema/Contact.Title';
export default class CreateRecordUsingApex extends LightningElement {
accName = '';
accFax = '';
isDisabled = true;

handleNameChange(event)
{
    this.accName = event.target.value;
    if(this.accName && this.accFax)
    {
        this.isDisabled = false;
    }
    else
    {
        this.isDisabled = true;
    }
}

handleFaxChange(event)
{
    this.accFax = event.target.value;
    if(this.accName && this.accFax)
    {
        this.isDisabled = false;
    }
    else
    {
        this.isDisabled = true;
    }
}

handleClick()
{
    CreateAccRecord({accName : this.accName, accFax : this.accFax})
    .then(result => {
        console.log("Created Record : "+ JSON.stringify(result));
        this.accFax = '';
        this.accName = '';
        this.showToastEvent();
    })

    .catch(error => {
        console.log('error : '+ JSON.stringify(error))
    })
}

showToastEvent()
{
    const event = new ShowToastEvent({
        title : 'Successful',
        message : 'Account Record Created Successfully !!!',
        variant : 'success'
    })
    this.dispatchEvent(event);
}


}