import 'package:catatan_keuanganku/app/base/base_view.dart';
import 'package:catatan_keuanganku/app/styles/color_pallete.dart';
import 'package:catatan_keuanganku/app/styles/text_style.dart';
import 'package:catatan_keuanganku/presentation/controller/master_type_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MasterTypePage extends BasePage<MasterTypeController> {
  MasterTypePage({super.key, required super.pageController}) {
    pageController.initialData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<MasterTypeController>(
        controller: pageController,
        builder: (context, controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Master Type Transaction'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => controller.openForm(),
              backgroundColor:
                  controller.indexTabSelected == 0 ? colorGreen : colorRed,
              shape: const CircleBorder(),
              child: Icon(
                Icons.add,
                color: colorPrimary,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                onTap: (value) => controller.actionTabSelect(value),
                currentIndex: controller.indexTabSelected,
                selectedItemColor: colorPrimary,
                showSelectedLabels: false,
                selectedIconTheme: const IconThemeData(size: 35),
                unselectedItemColor: colorAccent,
                unselectedFontSize: 15,
                items: const [
                  BottomNavigationBarItem(
                      label: 'Income',
                      icon: Icon(FontAwesomeIcons.moneyBill)),
                  BottomNavigationBarItem(
                      label: 'Outcome', icon: Icon(Icons.payment_rounded))
                ]),
            body: StreamBuilder(
              stream: controller.fetchTypeTransaction(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data![index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10 * controller.scaleWidth,
                              horizontal: 10 * controller.scaleWidth),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5 * controller.scaleWidth,
                                horizontal: 10 * controller.scaleWidth),
                            child: Text(
                              item.nameTransaction,
                              style: textLarge(
                                fontColor: colorPrimary,
                                isBold: true,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Data',
                        style: textLarge(
                          fontColor: colorRed,
                          isBold: true,
                        ),
                      ),
                    );
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
          );
        });
  }
}
