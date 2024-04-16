// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techfinix/constants.dart';
import 'package:techfinix/img_helper.dart';
import 'package:techfinix/widgets/textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_cropper/image_cropper.dart';

class AddExpenseForm extends StatefulWidget {
  final TextEditingController expenseControllers;
  final TextEditingController expenseIdControllers;
  final TextEditingController imageControllers;
  final TextEditingController descrpControllers;
  final TextEditingController amountControllers;
  final List<dynamic> expenseList;
  final Function(String) onTotalAmountChanged;
  final Function() onDelete;

  const AddExpenseForm({
    super.key,
    required this.amountControllers,
    required this.descrpControllers,
    required this.expenseControllers,
    required this.expenseIdControllers,
    required this.imageControllers,
    required this.expenseList,
    required this.onTotalAmountChanged,
    required this.onDelete,
  });

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  @override
  void initState() {
    super.initState();
    // getExpenseDropdown();
  }

  // Future getExpenseDropdown() async {
  //   final response = await HttpApiCall().getDropdownData();
  //   if (response.isNotEmpty && response['expense_array'].isNotEmpty) {
  //     // print(response['expense_array']);
  //     expenseList = response['expense_array'];
  //     setState(() {
  //       isDataLoaded = true;
  //     });
  //   }
  // }

  final ImageHelper _imageHelper = ImageHelper();
  File? _image;
  double totalAmount = 0.0;

  void convertImage() {
    List<int> imageBytes = File(_image!.path).readAsBytesSync();
    widget.imageControllers.text = base64Encode(imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 210),
                child: InkWell(
                  onTap: () {
                    widget.onDelete();
                  },
                  child: Container(
                    height: 30,
                    width: 92,
                    decoration: BoxDecoration(
                      color: red3.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          CupertinoIcons.delete,
                          color: red2,
                          size: 16,
                        ),
                        Text(
                          "REMOVE",
                          style: GoogleFonts.inter(
                            color: red2,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              DropdownMenu<dynamic>(
                width: MediaQuery.of(context).size.width * 0.86,
                initialSelection: widget.expenseList[0]['expense_name'],
                menuHeight: 200,
                textStyle: GoogleFonts.inter(
                  fontSize: 13,
                ),
                label: Text(
                  "Expense",
                  style: GoogleFonts.inter(color: grey1, fontSize: 13),
                ),
                trailingIcon: Icon(
                  CupertinoIcons.chevron_down,
                  color: grey1,
                  size: 20,
                ),
                selectedTrailingIcon: Icon(
                  CupertinoIcons.chevron_up,
                  color: color1,
                  size: 20,
                ),
                menuStyle: MenuStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.white,
                  ),
                  elevation: MaterialStatePropertyAll<double>(0.5),
                  side: MaterialStatePropertyAll(
                    BorderSide(
                      color: grey3,
                      width: 1,
                    ),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  constraints: const BoxConstraints(maxHeight: 50),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: grey1),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: grey1),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
                onSelected: (dynamic value) {
                  setState(() {
                    widget.expenseIdControllers.text =
                        value!['expense_id'].toString();
                    widget.expenseControllers.text = value!['expense_name'];
                  });
                },
                controller: widget.expenseControllers,
                dropdownMenuEntries: widget.expenseList
                    .map<DropdownMenuEntry<dynamic>>((dynamic value) {
                  return DropdownMenuEntry<dynamic>(
                    value: value,
                    label: value['expense_name'],
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: TextBox(
                      controller: widget.amountControllers,
                      hinttext: "Amount",
                      label: "",
                      obscureText: false,
                      labelFontsize: 13,
                      isNumber: true,
                      width: 150,
                      onChanged: (value) {
                        setState(() {
                          String totalAmount = widget.amountControllers.text;
                          widget.onTotalAmountChanged(totalAmount);
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  InkWell(
                    onTap: () async {
                      final file = await _imageHelper.getImage();
                      if (file != null) {
                        final cropped =
                            await _imageHelper.crop(file, CropStyle.rectangle);
                        if (cropped != null) {
                          setState(() {
                            _image = cropped;
                          });
                          convertImage();
                        }
                      }
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      strokeWidth: 0.8,
                      dashPattern: const [7, 7],
                      color: grey1,
                      child: Container(
                        height: 45,
                        width: 135,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        child: _image == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_upload_outlined,
                                    color: grey1,
                                    size: 20,
                                  ),
                                  Text(
                                    "Upload",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: grey1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(_image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: widget.descrpControllers,
                hinttext: "Description",
                label: "",
                obscureText: false,
                inputType: TextInputType.multiline,
                isNumber: false,
                labelFontsize: 13,
                height: 150,
                maxLines: 100,
                maxLength: 100,
                showCounter: true,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
