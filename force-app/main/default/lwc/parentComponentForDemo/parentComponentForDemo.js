import { LightningElement } from 'lwc';

export default class ParentComponentForDemo extends LightningElement {
    countValue = 0;
    showStatement = false;

    handleDecrement()
    {
        this.countValue-- ;
        if(this.countValue !== 0)
        {
            this.showStatement = true;
        }
        else
        {
            this.showStatement = false;
        }
    }

    handleIncrement()
    {
        this.countValue++ ;
        if(this.countValue !== 0)
        {
            this.showStatement = true;
        }
        else
        {
            this.showStatement = false;
        }
    }

    handleMul(event)
    {
        const multiplier = event.detail;
        this.countValue *= multiplier;
        if(this.countValue !== 0)
        {
            this.showStatement = true;
        }
        else
        {
            this.showStatement = false;
        }
    }



}