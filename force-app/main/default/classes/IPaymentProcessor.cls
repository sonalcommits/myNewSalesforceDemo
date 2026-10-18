public interface IPaymentProcessor {
    void processPayment(Decimal amount);
}