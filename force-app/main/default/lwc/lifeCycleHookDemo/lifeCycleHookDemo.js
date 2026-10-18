import { LightningElement } from 'lwc';

export default class LifeCycleHookDemo extends LightningElement {

    isVisibleChildComponent = true;
    constructor()
    {
        super();
        console.log('This call is from Parent Constructor');
    }

    connectedCallback()
    {
        console.log('This call is from Parent ConnectedCallBack');

    }

    renderedCallback()
    {
        console.log('This call is from Parent RenderedCallBack');

    }

    errorCallback()
    {
        console.log('This call is from Parent ErrorCallBack');

    }

    handleClick()
    {
        if(this.isVisibleChildComponent === false)
        {
            this.isVisibleChildComponent = true;
        }
        else{
            this.isVisibleChildComponent = false;
        }
    }
}