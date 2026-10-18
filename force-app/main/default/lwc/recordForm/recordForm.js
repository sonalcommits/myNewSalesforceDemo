import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import ACCOUNT_FIELD from '@salesforce/schema/Contact.AccountId';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

export default class RecordForm extends LightningElement {

    @api recordId;
    @api objectApiName;
    fields = [NAME_FIELD, ACCOUNT_FIELD, PHONE_FIELD, EMAIL_FIELD];
}