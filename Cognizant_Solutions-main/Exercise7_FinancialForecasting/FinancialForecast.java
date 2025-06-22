package Exercise7_FinancialForecasting;

public class FinancialForecast {

    public static double forecast(int year, double baseValue, double growthRate) {
        if (year == 0) {
            return baseValue;
        }
        return forecast(year - 1, baseValue, growthRate) * (1 + growthRate);
    }

    public static void main(String[] args) {
        double baseValue = 10000.0;
        double growthRate = 0.08;
        int years = 10;

        double result = forecast(years, baseValue, growthRate);
        System.out.printf("Forecasted value after %d years: ₹%.2f\n", years, result);
    }
}
