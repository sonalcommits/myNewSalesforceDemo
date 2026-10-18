import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import COUNTING_UPDATE_CHANNEL from '@salesforce/messageChannel/Counting_Update__c';
export default class PubLwc extends LightningElement {

    @wire(MessageContext)
    messageContext

    handleAddition()
    {
        const payLoad = {
            operator:'add',
            num:1
        }
        publish(this.messageContext, COUNTING_UPDATE_CHANNEL, payLoad);
    }

    handleSubstraction()
    {
         const payLoad = {
            operator:'substract',
            num:1
        }
        publish(this.messageContext, COUNTING_UPDATE_CHANNEL, payLoad);
    }

    handleMultiplication()
    {
         const payLoad = {
            operator:'multiply',
            num:2
        }
        publish(this.messageContext, COUNTING_UPDATE_CHANNEL, payLoad);
    }


}