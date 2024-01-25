import 'package:flutter_easyloading/flutter_easyloading.dart';

showLoading() async {
  await EasyLoading.show(
    status: 'loading...',
    maskType: EasyLoadingMaskType.black,
  );
}

hideLoading() async {
  if (EasyLoading.isShow) {
    await EasyLoading.dismiss();
  }
}