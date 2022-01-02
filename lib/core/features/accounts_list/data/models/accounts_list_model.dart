import 'dart:convert';

class AccountsListModel {
  String accountnumber;
  String name;
  int statecode;
  String address1_stateorprovince;
  AccountsListModel({
    this.accountnumber,
    this.name,
    this.statecode,
    this.address1_stateorprovince,
  });

  AccountsListModel copyWith({
    String accountnumber,
    String name,
    int statecode,
    String address1_stateorprovince,
  }) {
    return AccountsListModel(
      accountnumber: accountnumber ?? this.accountnumber,
      name: name ?? this.name,
      statecode: statecode ?? this.statecode,
      address1_stateorprovince:
          address1_stateorprovince ?? this.address1_stateorprovince,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accountnumber': accountnumber,
      'name': name,
      'statecode': statecode,
      'address1_stateorprovince': address1_stateorprovince,
    };
  }

  factory AccountsListModel.fromMap(Map<String, dynamic> map) {
    return AccountsListModel(
      accountnumber: map['accountnumber'] ?? '',
      name: map['name'] ?? '',
      statecode: map['statecode']?.toInt() ?? 0,
      address1_stateorprovince: map['address1_stateorprovince'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountsListModel.fromJson(String source) =>
      AccountsListModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AccountsListModel(accountnumber: $accountnumber, name: $name, statecode: $statecode, address1_stateorprovince: $address1_stateorprovince)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountsListModel &&
        other.address1_stateorprovince == address1_stateorprovince;
  }

  @override
  int get hashCode {
    return address1_stateorprovince.hashCode;
  }
}
