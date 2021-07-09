import 'package:bc_app/providers/baseProvider.dart';
import 'package:bc_app/services/contactService.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ContactProvider extends BaseProvider{
  bool isBusy = false;
  ContactService _contactService = ContactService();

  call(String phoneNumber) {
    FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  Future<http.Response> MailBc(String username, telephone, email) async{
    print('sending mail...');
    isBusy = true;
    notifyListeners();
    var response =  await _contactService.mail(username, telephone, email);
    if(response.statusCode == 200 || response.statusCode == 201){
      print('data --> ${response.body}');
      notifyListeners();
      isBusy = false;
    }
  }

  Future<http.Response> rec_sugg(int iduser, int idreason, String description, String record) async{
    print('sending rec_sugg...');
    isBusy = true;
    notifyListeners();
    var response =  await _contactService.rec_sugg(iduser, idreason, description, record);
    isBusy = false;
    notifyListeners();
  }



  Future<void> mailSeller(String email) async{
    final Uri params = Uri(
      scheme: 'mailto',
      path: '$email',
      query: 'subject=test',
    );
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}