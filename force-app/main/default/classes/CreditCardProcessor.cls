public class CreditCardProcessor implements IPaymentProcessor{
   public void processPayment(Decimal amount)
    {
        System.debug('Charging $ '+ amount+ ' via Visa/MasterCard gateway.');
    }

}