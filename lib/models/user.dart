class User{

  final int iduser, idrole, idagent, agentIduser;
  final String firstName, lastName, userName, email, password, entrepriseName, ice, city, address,
      telephone, clientNumber, agentName, profileImage, solde, ristourne, agentPhone,
      firstConnection, banquette, divers, matelas, mousse, from_date_ca, to_date_ca;

  User(this.iduser, this.idagent, this.firstName, this.lastName, this.userName, this.email, this.password,
      this.entrepriseName, this.ice, this.city, this.address, this.telephone,
      this.clientNumber, this.agentIduser, this.agentName, this.idrole, this.profileImage, this.solde, this.ristourne, this.agentPhone,
      this.firstConnection, this.banquette, this.divers, this.matelas, this.mousse, this.from_date_ca, this.to_date_ca);


  dynamic toJson() => {'iduser': iduser, 'idagent': idagent, 'firstName': firstName, 'lastName': lastName,
    'userName': userName, 'email': email, 'password': password, 'entrepriseName': entrepriseName, 'ice': ice,
    'city': city, 'address': address, 'telephone': telephone, 'code': clientNumber,
    'agentIduser': agentIduser, 'agentName': agentName, 'idrole': idrole,
    'profileImage': profileImage, 'solde': solde, 'ristourne': ristourne, 'agentPhone': agentPhone,
    'firstConnection': firstConnection, 'banquette': banquette,
    'divers': divers, 'matelas': matelas, 'mousse': mousse, 'from_date_ca': from_date_ca,
    'to_date_ca': to_date_ca
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
        agentPhone = json['agentPhone'],
        firstConnection = json['firstConnection'],
        banquette = json['banquette'],
        divers = json['divers'],
        matelas = json['matelas'],
        mousse = json['mousse'],
        from_date_ca = json['from_date_ca'],
        to_date_ca = json['to_date_ca'],
        profileImage = json['profileImage'];
}