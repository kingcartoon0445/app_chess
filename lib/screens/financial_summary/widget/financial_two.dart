import 'package:app_chess/theme_extension.dart';
import 'package:flutter/material.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({Key? key}) : super(key: key);

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  // List of device states
  List<bool> deviceStates = [true, true, true, false, false];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Danh sách thiết bị',
              style: context.textTheme.titleLarge!.copyWith(
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: Center(
                            child: Text('Thiết bị',
                                style: context.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.grey[800]!,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text('Trạng thái',
                                style: context.textTheme.labelMedium!.copyWith(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Device list
                ...List.generate(
                  5,
                  (index) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index == 4
                              ? Colors.transparent
                              : Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: Text('Thiết bị A',
                                style: context.textTheme.labelSmall!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Switch(
                              value: deviceStates[index],
                              onChanged: (bool value) {
                                setState(() {
                                  deviceStates[index] = value;
                                });
                              },
                              activeTrackColor: context.theme.primaryColor,
                              activeColor: Colors.white,
                              inactiveThumbColor:
                                  Colors.white, // context.theme.primaryColor,
                              inactiveTrackColor:
                                  context.theme.primaryColor.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
