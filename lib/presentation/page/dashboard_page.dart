import 'package:catatan_keuanganku/app/base/base_view.dart';
import 'package:catatan_keuanganku/app/common/string_formatter.dart';
import 'package:catatan_keuanganku/app/styles/color_pallete.dart';
import 'package:catatan_keuanganku/app/styles/text_style.dart';
import 'package:catatan_keuanganku/data/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/dashboard_controller.dart';

class DashboardPage extends BasePage<DashboardController> {
  DashboardPage({super.key, required super.pageController});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<DashboardController>(
        controller: pageController,
        builder: (context, controller) {
          return Scaffold(
            key: controller.scaffoldKey,
            endDrawer: Drawer(
              backgroundColor: colorPrimary,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15 * controller.scaleWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Menu',
                          style: textLarge(
                            fontColor: colorText,
                            isBold: true,
                          ),
                        ),
                        Divider(
                          color: colorAccent,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () => controller.actionOpenMaster(),
                    leading: Icon(
                      Icons.menu_book_rounded,
                      color: colorAccent,
                    ),
                    title: Text(
                      'Master Type Transaction',
                      style: textMedium(
                        fontColor: colorAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: Stack(
              children: [
                Container(
                  height: controller.sizeHeight / 3.5,
                  color: colorPrimary,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 25 * controller.scaleWidth,
                        horizontal: 25 * controller.scaleWidth,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gustav Sri Raharjo',
                            style: textLarge(fontColor: colorAccent),
                          ),
                          InkWell(
                              onTap: () => controller.actionOpenDrawer(),
                              child: Icon(
                                Icons.menu_rounded,
                                color: colorAccent,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: controller.sizeHeight / 4.5,
                      width: controller.sizeWidth,
                      padding: EdgeInsets.symmetric(
                        vertical: 15 * controller.scaleWidth,
                        horizontal: 10 * controller.scaleWidth,
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: 25 * controller.scaleWidth),
                      decoration: BoxDecoration(
                          color: colorText,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance'.toUpperCase(),
                            style: textMedium(fontColor: colorPrimary),
                          ),
                          SizedBox(
                            height: 5 * controller.scaleWidth,
                          ),
                          Text(
                            currencyFormatter(controller.totalBalance)
                                .replaceAll('-', ''),
                            style: textLarge(
                              fontColor: controller.totalBalance < 0
                                  ? colorRed
                                  : colorGreen,
                              isBold: true,
                            ),
                          ),
                          SizedBox(
                            height: 20 * controller.scaleWidth,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buttonExpense('Income'),
                              buttonExpense('Outcome')
                            ],
                          )
                        ],
                      ),
                    ),
                    StreamBuilder<List<Transaction>>(
                        stream: controller.fetchTransaction(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var item = snapshot.data![index];
                                    return Card(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5 * controller.scaleWidth,
                                          horizontal:
                                              15 * controller.scaleWidth),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10 * controller.scaleWidth,
                                            horizontal:
                                                10 * controller.scaleWidth),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    DateFormat('dd-MMM-yyyy')
                                                        .format(item.date),
                                                    style: textLarge(
                                                        fontColor: colorAccent,
                                                        isBold: true),
                                                  ),
                                                  SizedBox(
                                                    height: 10 *
                                                        controller.scaleWidth,
                                                  ),
                                                  Text(
                                                    item.title,
                                                    style: textMedium(
                                                      fontColor: colorPrimary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              currencyFormatter(item.nominal),
                                              style: textLargeXtra(
                                                  fontColor:
                                                      item.typeTransaction == 0
                                                          ? colorGreen
                                                          : colorRed,
                                                  isBold: true),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'No Data',
                                  style: textLarge(fontColor: colorRed),
                                ),
                              );
                            }
                          } else {
                            return Center(
                              child: Text(
                                'Loading...',
                                style: textLarge(fontColor: colorPrimary),
                              ),
                            );
                          }
                        })
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget buttonExpense(String title) {
    return ControlledWidgetBuilder<DashboardController>(
        builder: (context, controller) {
      return InkWell(
        onTap: () =>
            controller.actionOpenFormTransaction(title == 'Income' ? 0 : 1),
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: colorPrimary,
            ),
            child: Row(
              children: [
                Text(
                  title,
                  style: textLarge(fontColor: colorAccent),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  title == 'Income'
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  color: colorAccent,
                )
              ],
            )),
      );
    });
  }

  Widget cardNominal(String title, int nominal) {
    return ControlledWidgetBuilder<DashboardController>(
        builder: (context, controller) {
      return SizedBox(
        height: controller.sizeHeight / 8,
        child: Card(
          elevation: 2,
          color: colorPrimary,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: colorAccent),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: textMedium(
                    fontColor: colorAccent,
                  ),
                ),
                SizedBox(
                  height: 5 * controller.scaleWidth,
                ),
                Text(
                  currencyFormatter(nominal),
                  style: textLarge(
                    fontColor: title == 'Outcome' ? colorRed : colorGreen,
                    isBold: true,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
