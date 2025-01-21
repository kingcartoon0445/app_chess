import 'package:app_chess/bloc/device/device_bloc.dart';
import 'package:app_chess/bloc/device/device_event.dart';
import 'package:app_chess/bloc/device/device_state.dart';
import 'package:app_chess/bloc/summary/summary_export.dart';
import 'package:app_chess/screens/financial_summary/widget/financial_two.dart';
import 'package:app_chess/screens/login/login_page.dart';
import 'package:app_chess/services/model/device_response.dart';
import 'package:app_chess/ui/loading_common.dart';
import 'package:app_chess/ui/widget/dialog_common.dart';
import 'package:app_chess/util/shared_preferences_setup.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../bloc/login_bloc/login_export.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeviceBloc(
        dioService: DioService(),
      ),
      child: const DeviceView(),
    );
  }
}

class DeviceView extends StatefulWidget {
  const DeviceView({Key? key}) : super(key: key);

  @override
  State<DeviceView> createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  void initState() {
    context.read<DeviceBloc>().add(
          FetchDevice(),
        );
    super.initState();
  }

  List<DeviceModel>? deviceModeles = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeviceBloc, DeviceState>(
      listener: (context, state) {
        if (state is DeviceLoading) {
          LoadingDialog.show(
            context,
            customLoadingWidget: CustomLoadingWidget(
              // color: Colors.red,
              size: 40,
            ),
            message: 'loading'.tr(),
          );
        }

        if (state is DeviceError) {
          LoadingDialog.hide(context);
          if (state.message == 'Unauthenticated.') {
            final prefs = SharedPrefsService();
            prefs.clear();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (Route<dynamic> route) => true,
            );
            DialogCommon()
                .showErrorDialog(context, message: "unauthenticated".tr());
          } else {
            DialogCommon()
                .showErrorDialog(context, message: 'Error: ${state.message}');
          }
        }
        if (state is DeviceUpdateDone) {
          LoadingDialog.hide(context);
          DialogCommon().showSuccessDialog(
            context,
            message: "update_status_done".tr(),
            onButtonPressed: () {},
          );
          context.read<DeviceBloc>().add(
                FetchDevice(),
              );
        }
        if (state is DeviceLoaded) {
          LoadingDialog.hide(context);
          setState(() {
            deviceModeles = state.deviceModeles;
          });
          // return FinancialDeviceScreen();
        }
      },
      child: DeviceListScreen(
        deviceModeles: deviceModeles,
      ),
    );
  }
}
