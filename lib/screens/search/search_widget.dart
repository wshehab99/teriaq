import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchTextFeild extends StatelessWidget {
  SearchTextFeild(
      {Key? key,
      this.hint,
      this.onSearch,
      this.controller,
      this.searchTextFeildBorderRadius,
      this.searchTextFeildColor})
      : super(key: key);
  String? hint;
  Color? searchTextFeildColor = Colors.white70;
  BorderRadius? searchTextFeildBorderRadius = BorderRadius.circular(35);
  TextEditingController? controller;
  Function(String?)? onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 45,
      decoration: BoxDecoration(
          color: searchTextFeildColor, borderRadius: BorderRadius.circular(35)),
      child: TextField(
        controller: controller,
        onChanged: onSearch,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            suffixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: Colors.transparent))),
      ),
    );
  }
}
