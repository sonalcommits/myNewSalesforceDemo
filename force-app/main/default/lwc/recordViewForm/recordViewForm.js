import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import ACCOUNT_FIELD from '@salesforce/schema/Contact.AccountId';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

export default class RecordViewForm extends LightningElement {

    nameField = NAME_FIELD;
    accountField = ACCOUNT_FIELD;
    phoneField = PHONE_FIELD;
    emailField = EMAIL_FIELD;
    objectApiName = CONTACT_OBJECT;

    @api recordId;
}