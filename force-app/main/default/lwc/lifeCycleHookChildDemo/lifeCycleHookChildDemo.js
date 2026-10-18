import { LightningElement } from 'lwc';

export default class LifeCycleHookChildDemo extends LightningElement {

     constructor()
    {
        super();
        console.log('This call is from Child Constructor');
    }

    connectedCallback()
    {
        console.log('This call is from Child ConnectedCallBack');

    }

    renderedCallback()
    {
        console.log('This call is from Child RenderedCallBack');

    }

    disconnectedCallback()
    {
        console.log('This call is from Child DisconnectedCallBack');
    }
}