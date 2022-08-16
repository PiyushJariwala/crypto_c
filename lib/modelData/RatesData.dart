class RatesData {
  List<Data>? data;
  int? timestamp;

  RatesData({this.data, this.timestamp});

  RatesData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Data {
  String? id;
  String? symbol;
  String? currencySymbol;
  String? type;
  String? rateUsd;

  Data({this.id, this.symbol, this.currencySymbol, this.type, this.rateUsd});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    currencySymbol = json['currencySymbol'];
    type = json['type'];
    rateUsd = json['rateUsd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['currencySymbol'] = this.currencySymbol;
    data['type'] = this.type;
    data['rateUsd'] = this.rateUsd;
    return data;
  }
}
