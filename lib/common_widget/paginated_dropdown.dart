import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginatedDropdown<T> extends StatefulWidget {
  final String hint;
  final T? selectedValue;
  final List<T> items;
  final String Function(T) itemLabel;
  final dynamic Function(T) itemValue;
  final Function(T?) onChanged;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMoreData;
  final VoidCallback? onLoadMore;
  final bool isSearchable;

  const PaginatedDropdown({
    Key? key,
    required this.hint,
    this.selectedValue,
    required this.items,
    required this.itemLabel,
    required this.itemValue,
    required this.onChanged,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMoreData = false,
    this.onLoadMore,
    this.isSearchable = true,
  }) : super(key: key);

  @override
  State<PaginatedDropdown<T>> createState() => _PaginatedDropdownState<T>();
}

class _PaginatedDropdownState<T> extends State<PaginatedDropdown<T>> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<T> _filteredItems = [];
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didUpdateWidget(PaginatedDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _updateFilteredItems();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (widget.hasMoreData &&
          !widget.isLoadingMore &&
          widget.onLoadMore != null) {
        widget.onLoadMore!();
      }
    }
  }

  void _onSearchChanged() {
    _updateFilteredItems();
  }

  void _updateFilteredItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = widget.items.where((item) {
        return widget.itemLabel(item).toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isDropdownOpen = !_isDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.selectedValue != null
                        ? widget.itemLabel(widget.selectedValue!)
                        : widget.hint,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: widget.selectedValue != null
                          ? Colors.black87
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
                Icon(
                  _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
        if (_isDropdownOpen) ...[
          SizedBox(height: 4.h),
          Container(
            constraints: BoxConstraints(maxHeight: 200.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                if (widget.isSearchable) ...[
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search, size: 20.sp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                      ),
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                ],
                Expanded(
                  child: widget.isLoading
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        )
                      : _filteredItems.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.w),
                                child: Text(
                                  'No items found',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: _filteredItems.length +
                                  (widget.hasMoreData ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == _filteredItems.length) {
                                  // Loading more indicator
                                  return Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Center(
                                      child: widget.isLoadingMore
                                          ? SizedBox(
                                              width: 20.w,
                                              height: 20.h,
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              'Scroll to load more',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                    ),
                                  );
                                }

                                final item = _filteredItems[index];
                                final isSelected = widget.selectedValue !=
                                        null &&
                                    widget.itemValue(item) ==
                                        widget.itemValue(widget.selectedValue!);

                                return InkWell(
                                  onTap: () {
                                    widget.onChanged(item);
                                    setState(() {
                                      _isDropdownOpen = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 12.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.blue.shade50
                                          : Colors.transparent,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.itemLabel(item),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: isSelected
                                                  ? Colors.blue.shade700
                                                  : Colors.black87,
                                              fontWeight: isSelected
                                                  ? FontWeight.w500
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        if (isSelected)
                                          Icon(
                                            Icons.check,
                                            color: Colors.blue.shade700,
                                            size: 18.sp,
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
