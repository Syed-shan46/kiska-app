import 'package:kiska/features/authentication/global_varaibles.dart';
import 'package:kiska/features/shop/models/address_model.dart';
import 'package:http/http.dart' as http;
import 'package:kiska/services/http_response.dart';

class AddressController {
  uploadAddress({
    required String name,
    required String phone,
    required String country,
    required String city,
    required String address,
    required context,
  })  async{
    try {
      Address addressModel = Address(
          id: 'id',
          name: name,
          phone: phone,
          country: country,
          city: city,
          address: address);

     http.Response response =await http.post(Uri.parse('$uri/api/add-address'),
          body: addressModel.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });

          manageHttpResponse(response: response, context: context, onSuccess: (){
            showSnackBar(context, 'Address Created');
          });
    } catch (e) { 
      showSnackBar(context, 'Error$e');
    }
  }
}
