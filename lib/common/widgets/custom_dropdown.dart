import 'package:flutter/material.dart';
import 'package:hosomobile/features/home/screens/upgrades/home/components/image.dart';

class CustomDropdown extends StatefulWidget {
  final List<Map<dynamic, String>> itemLists;
  final Function(String?)? onChanged;
  final String title;
  final double width;
  final double menuWidth;
  final double menuHeight;
  final String prefixIcon;
  final double iconSize;
  final String? errorText;

  const CustomDropdown({
    super.key,
    required this.onChanged,
    required this.prefixIcon,
    required this.itemLists,
    required this.title,
    required this.width,
    required this.menuWidth,
    required this.menuHeight,
    this.iconSize = 20,
    this.errorText,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Map<dynamic, String>? _selectedItem;
  bool _isMenuOpen = false;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isMenuOpen) {
        _hideMenu();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _hideMenu();
    super.dispose();
  }

  void _showMenu() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: widget.menuWidth,
        height: widget.menuHeight,
        left: offset.dx,
        top: offset.dy + size.height + 5,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 4, right: 4, top: 10),
                          child: SizedBox(
                            width: widget.iconSize,
                            height: widget.iconSize,
                            child: IconImages(widget.prefixIcon),
                          ),
                        ),
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  Expanded(
                    child: _buildFilteredList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isMenuOpen = true);
  }

  void _hideMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() => _isMenuOpen = false);
  }

  Widget _buildFilteredList() {
    final filteredItems = widget.itemLists.where((item) {
      final searchTerm = _searchController.text.toLowerCase();
      return item['name']?.toLowerCase().contains(searchTerm) ?? false;
    }).toList();

    if (filteredItems.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          widget.errorText ?? 'No results found',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return ListTile(
         
          leading: SizedBox(
            width: widget.iconSize,
            height: widget.iconSize,
            child: IconImages(item['logo'] ?? widget.prefixIcon),
          ),
          title: Text(item['name'] ?? ''),
          trailing: Text(
            item['status'] ?? '',
            style: TextStyle(
              color: item['status'] == 'available' ? Colors.green : Colors.red,
            ),
          ),
          onTap: () {
            setState(() => _selectedItem = item);
            widget.onChanged?.call(item['name']);
            _hideMenu();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () => _isMenuOpen ? _hideMenu() : _showMenu(),
        child: Focus(
          focusNode: _focusNode,
          child: Container(
            width: widget.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.errorText != null ? Colors.red : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4, top: 10),
                  child: SizedBox(
                    width: widget.iconSize,
                    height: widget.iconSize,
                    child: IconImages(
                      _selectedItem != null && _selectedItem!['logo'] != null
                          ? _selectedItem!['logo']!
                          : widget.prefixIcon,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    _selectedItem != null ? _selectedItem!['name'] ?? '' : widget.title,
                    style: TextStyle(
                      color: widget.errorText != null ? Colors.red : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (_selectedItem != null)
                  Text(
                    _selectedItem!['status'] ?? '',
                    style: TextStyle(
                      color: widget.errorText != null
                          ? Colors.red
                          : _selectedItem!['status'] == 'available'
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ),
    );
  }
}