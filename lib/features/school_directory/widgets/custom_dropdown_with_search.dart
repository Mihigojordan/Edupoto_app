import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/home/controllers/all_school_controller.dart';

class CustomDropdownWithSearch<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String hintText;
  final String? errorText;
  final String Function(T? item) itemToString;
  final void Function(T?)? onChanged;
  final bool isEnabled;

  const CustomDropdownWithSearch({
    required this.items,
    required this.selectedItem,
    required this.hintText,
    this.errorText,
    required this.itemToString,
    this.onChanged,
    this.isEnabled = true,
  });

  @override
  State<CustomDropdownWithSearch<T>> createState() => _CustomDropdownWithSearchState<T>();
}

class _CustomDropdownWithSearchState<T> extends State<CustomDropdownWithSearch<T>> {
  late FocusNode _dropdownFocusNode;
  late List<T> _filteredItems;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;

  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _dropdownFocusNode = FocusNode();
    _filteredItems = List<T>.from(widget.items);
    _dropdownFocusNode.addListener(_onDropdownFocusChange);
      _scrollController.addListener(_scrollListener);
  }

  @override
  void didUpdateWidget(covariant CustomDropdownWithSearch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      setState(() {
        _filteredItems = List<T>.from(widget.items);
      });
    }
  }

  @override
  void dispose() {
    _dropdownFocusNode.removeListener(_onDropdownFocusChange);
    _dropdownFocusNode.dispose();
    _removeOverlay();
     _scrollController.dispose();
    super.dispose();
  }

    void _scrollListener() {
    if (_scrollController.position.pixels == 
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

   void _loadMoreItems() {
    // Call your controller's method to load more items
    // For example:
   Get.find<AllSchoolController>().getSchoolList(false);
  }

  void _onDropdownFocusChange() {
    if (_dropdownFocusNode.hasFocus && !_isDropdownOpen) {
      _showOverlay();
    } else if (!_dropdownFocusNode.hasFocus && _isDropdownOpen) {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),),
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                   if (index >= _filteredItems.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final item = _filteredItems[index];
                  return InkWell(
                    onTap: () {
                      widget.onChanged?.call(item);
                      _dropdownFocusNode.unfocus();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        widget.itemToString(item),
                        style: TextStyle(
                          color: widget.isEnabled
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isDropdownOpen = true;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isDropdownOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: () {
              if (widget.isEnabled && widget.onChanged != null) {
                if (_isDropdownOpen) {
                  _dropdownFocusNode.unfocus();
                } else {
                  _dropdownFocusNode.requestFocus();
                }
              }
            },
            child: Focus(
              focusNode: _dropdownFocusNode,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: widget.isEnabled && widget.onChanged != null
                        ? (widget.selectedItem == null
                            ? Colors.grey
                            : Colors.amber)
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.selectedItem != null
                            ? widget.itemToString(widget.selectedItem)
                            : widget.hintText,
                        style: TextStyle(
                          color: widget.selectedItem != null
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: widget.isEnabled && widget.onChanged != null
                          ? Colors.grey
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.errorText != null &&
            (widget.selectedItem == null || !widget.isEnabled))
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}