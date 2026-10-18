public class Calculator {
    //Method overloading
	public static Integer add(Integer num1, Integer num2)
    {
        System.debug('1st Method Invoked');
        return num1+num2;
    }
    public static Integer add(Integer num1, Integer num2, Integer num3)
    {
        System.debug('2nd Method Invoked');
        return num1+num2;
    }
    public static Decimal add(Decimal num1, Integer num2)
    {
        System.debug('3rd Method Invoked');
        return num1+num2;
    }
    public static Decimal add(Integer num1, Decimal num2)
    {
        System.debug('4th Method Invoked');
        return num1+num2;
    }
}