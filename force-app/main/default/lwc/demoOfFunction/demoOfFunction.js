import { LightningElement } from 'lwc';
import {ShowToastEvent} from'lightning/platformShowToastEvent';

export default class DemoOfFunction extends LightningElement {
    mydata = 'This is the demo of Function';
   handleClick()
   {
    this.showToastEvent();
   }

   showToastEvent()
   {
    const event = new ShowToastEvent({
        title: 'Show Toast Event',
        message: 'Want to display toast example',
        variant: 'error' // we use success, warning, error here
    });
    this.dispatchEvent(event);// method of LightningElement - it is parent class method
   }

}