import 'package:fcmapp/SecondScreen.dart';
import 'package:get/get.dart';

class MyRedirectionService extends GetxService
{

  var data="".obs;

  onReceivedData(var data){
    print("Calback MyRedirectionService onReceivedData $data");
    try{
      this.data.value=data ;
      this.data.refresh();

      Get.to(SecondScreeen());
    }catch(e)
    {
      print("Calback Error onReceivedData $e");
    }

  }

}