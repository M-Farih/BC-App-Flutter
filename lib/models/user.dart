

class User{

  final int id;
  final String fname, lname, username, password, company, ice, city, address, telephone, cNumber;

  User(this.id, this.fname, this.lname, this.username, this.password, this.company, this.ice, this.city, this.address, this.telephone, this.cNumber);


  dynamic toJson() => {'id': id, 'fname': fname, 'lname': lname, 'username': username,
    'password': password, 'company': company, 'ice': ice, 'city': city, 'address': address, 'telephone': telephone, 'cNumber': cNumber
  };

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fname = json['fname'],
        lname = json['lname'],
        username = json['username'],
        password = json['password'],
        company = json['company'],
        ice = json['ice'],
        city = json['city'],
        address = json['address'],
        telephone = json['telephone'],
        cNumber = json['cNumber'];
}