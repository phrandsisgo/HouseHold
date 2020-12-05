
//dependencie from pubspec .yaml
import 'package:cloud_functions/cloud_functions.dart';
class FirebaseFunctionsCloud {
  //making an instance of my Function
  final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName:'newData'
  );

  final HttpsCallable haushaltsInstanz = CloudFunctions.instance.getHttpsCallable(functionName: null);

 Future changeConsole()async{
    dynamic resp = await callable.call();
 }


 //das ist die Funktion die ein neuer Haushalt macht
 Future newHaushalt(String adminUID, String haushaltsname)async{
   dynamic resp = await haushaltsInstanz.call(<String, dynamic>{
    'admin user uid': adminUID,
    'haushaltsname': haushaltsname,
});
 }
}