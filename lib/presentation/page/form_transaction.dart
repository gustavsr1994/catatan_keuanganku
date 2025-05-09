import 'package:catatan_keuanganku/app/base/base_view.dart';
import 'package:catatan_keuanganku/app/styles/color_pallete.dart';
import 'package:catatan_keuanganku/app/styles/text_style.dart';
import 'package:catatan_keuanganku/presentation/controller/transaction_controller.dart';
import 'package:flutter/material.dart';

class FormTransaction extends BasePage<TransactionController> {
  final int typeTransaction;
  FormTransaction(this.typeTransaction,
      {super.key, required super.pageController}) {
    pageController.initialData(typeTransaction);
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<TransactionController>(
        controller: pageController,
        builder: (context, controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: colorPrimary,
              leading: BackButton(
                color: colorAccent,
              ),
              title: Text(
                typeTransaction == 0
                    ? 'Form Transaction Income'
                    : 'Form Transaction Outcome',
                style: textLarge(
                  fontColor: colorAccent,
                  isBold: true,
                ),
              ),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10 * controller.scaleWidth,
                      horizontal: 15 * controller.scaleWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type Transaction',
                        style:
                            textMedium(fontColor: colorPrimary, isBold: true),
                      ),
                      SizedBox(
                        height: 10 * controller.scaleWidth,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: colorPrimary)),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: controller.typeSelected,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15 * controller.scaleWidth),
                          underline: const SizedBox(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          items: controller.listTypeTransaction
                              .map(
                                (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style:
                                          textMedium(fontColor: colorPrimary),
                                    )),
                              )
                              .toList(),
                          onChanged: (value) => controller.selectType(value!),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10 * controller.scaleWidth,
                      horizontal: 15 * controller.scaleWidth),
                  child: TextFormField(
                    controller: controller.nameField,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Insert Transaction Title',
                        labelStyle: textLarge(fontColor: colorPrimary),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10 * controller.scaleWidth,
                      horizontal: 15 * controller.scaleWidth),
                  child: TextFormField(
                    controller: controller.dateField,
                    readOnly: true,
                    onTap: () => controller.openDatePicker(),
                    decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: 'Insert Transaction Date',
                        labelStyle: textLarge(fontColor: colorPrimary),
                        suffixIcon: const Icon(Icons.calendar_month_rounded),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10 * controller.scaleWidth,
                      horizontal: 15 * controller.scaleWidth),
                  child: TextFormField(
                    controller: controller.nominalField,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Nominal',
                        hintText: 'Insert Transaction Nominal',
                        labelStyle: textLarge(fontColor: colorPrimary),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10 * controller.scaleWidth,
                      horizontal: 15 * controller.scaleWidth),
                  child: TextFormField(
                    controller: controller.descriptionField,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Insert Transaction Description',
                        labelStyle: textLarge(fontColor: colorPrimary),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20 * controller.scaleWidth,
                      horizontal: 15 * controller.scaleWidth),
                  child: ElevatedButton(
                      onPressed: () => controller.addTransaction(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorPrimary,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15 * controller.scaleWidth),
                        child: Text(
                          'Submit',
                          style:
                              textLarge(fontColor: colorAccent, isBold: true),
                        ),
                      )),
                )
              ],
            ),
          );
        });
  }
}
