public class LuxuryTaxCalculator extends TaxCalculator {
    public override Decimal calculateTax(Decimal income)
 {
     return income*0.25;
 }
    
}