import { LightningElement } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
export default class NavigationServiceDemo extends NavigationMixin(LightningElement) {

    handleNavigation()
    {
       /*  console.log('Getting Invoked');

        //Navigation to Object Home Page
        
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName : 'Contact',
                actionName:'home'
            }
        })
    } */

/*  //Navigate to object Home Page with specific filter
 this[NavigationMixin.Navigate]({
    type: 'standard__objectPage',
    attributes: {
                objectApiName : 'Contact',
                actionName:'home'
            },
            state:{
                filterName: 'AllContacts' //this is the filter Name
            }
 })        */


       /*  // Navigate to Create New Record Page
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName : 'Contact',
                actionName : 'new'
            }
        })     */

       /*  // Navigate to  Record Page
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                recordId: '003gK00000rttgTQAQ',
                objectApiName : 'Contact',
                actionName : 'edit'
            }
        })    
 */
         /*     // Navigate to  Record Page
         this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '003gK00000qjC0DQAU',
                objectApiName : 'Contact',
                actionName : 'view'
            }
        })  */
        
          // Navigate to  External website
         this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://www.google.com'
            }
        }) 
}}