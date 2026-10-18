import { LightningElement } from 'lwc';

export default class ParentComponentForApi extends LightningElement {
    handleClick()

    {
        this.template.querySelector('c-child-component-for-api').handleCallFromParent();
    }
}