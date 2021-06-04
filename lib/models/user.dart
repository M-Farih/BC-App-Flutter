class User{

  final int iduser, idrole, idagent, agentIduser;
  final String firstName, lastName, userName, email, password, entrepriseName, ice, city, address,
      telephone, clientNumber, agentName, profileImage, solde, ristourne;

  User(this.iduser, this.idagent, this.firstName, this.lastName, this.userName, this.email, this.password,
      this.entrepriseName, this.ice, this.city, this.address, this.telephone,
      this.clientNumber, this.agentIduser, this.agentName, this.idrole, this.profileImage, this.solde, this.ristourne);


  dynamic toJson() => {'iduser': iduser, 'idagent': idagent, 'firstName': firstName, 'lastName': lastName,
    'userName': userName, 'email': email, 'password': password, 'entrepriseName': entrepriseName, 'ice': ice,
    'city': city, 'address': address, 'telephone': telephone, 'code': clientNumber,
    'agentIduser': agentIduser, 'agentName': agentName, 'idrole': idrole,
    'profileImage': profileImage, 'solde': solde, 'ristourne': ristourne
  };

  User.fromJson(Map<String, dynamic> json)
      : iduser = json['iduser'],
        idagent = json['idagent'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        userName = json['userName'],
        email = json['email'],
        password = json['password'],
        entrepriseName = json['entrepriseName'],
        ice = json['ice'],
        city = json['city'],
        address = json['address'],
        telephone = json['telephone'],
        clientNumber = json['code'],
        agentIduser = json['agentIduser'],
        agentName = json['agentName'],
        idrole = json['idrole'],
        solde = json['solde'],
        ristourne = json['ristourne'],
        profileImage = json['profileImage'];
}