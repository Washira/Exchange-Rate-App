import 'dart:convert';

ExchangeRateCurrency exchangeRateCurrencyFromJson(String str) => ExchangeRateCurrency.fromJson(json.decode(str));

String exchangeRateCurrencyToJson(ExchangeRateCurrency data) => json.encode(data.toJson());

class ExchangeRateCurrency {
    ExchangeRateCurrency({
        this.rates,
        this.base,
        this.date,
    });

    Map<String, double> rates;
    String base;
    DateTime date;

    factory ExchangeRateCurrency.fromJson(Map<String, dynamic> json) => ExchangeRateCurrency(
        rates: json["rates"] == null ? null : Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        base: json["base"] == null ? null : json["base"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "rates": rates == null ? null : Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "base": base == null ? null : base,
        "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}