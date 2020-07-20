import 'dart:async';
import 'package:flutter/material.dart';

typedef RetrieveDataCallback<T> = Future<bool> Function(
    int page, List<T> items, bool refresh);
typedef ItemBuilder<T> = Widget Function(T e, BuildContext ctx);
typedef IndexedItemBuilder<T> = Widget Function(
    List<T> list, int index, BuildContext ctx);

typedef LoadErrorCallback = void Function(dynamic e, bool isFirstPage);

class LoadingState<T> {
  List<T> items = [];
  dynamic error;
  bool loading = false;
  int currentPage = 0;
  bool noMore = false;

  bool get initialized => items.isNotEmpty || noMore;
}

class InfiniteListView<T> extends StatefulWidget {
  InfiniteListView({
    Key key,
    @required this.onRetrieveData,
    @required this.itemBuilder,
    this.initFailBuilder,
    this.initLoadingBuilder,
    this.scrollController,
    this.pageSize = 30,
    this.loadMoreErrorViewBuilder,
    this.loadingBuilder,
    this.headerBuilder,
    this.noMoreViewBuilder,
    this.sliver = false,
    this.separatorBuilder,
    this.emptyBuilder,
    this.initState,
    this.physics,
  }) : super(key: key);

  ///每个数据请求计数
  final int pageSize;

  ///数据回调
  final RetrieveDataCallback<T> onRetrieveData;

  ///第一页加载指示器
  final WidgetBuilder initLoadingBuilder;

  ///第一页加载指示器
  final WidgetBuilder loadingBuilder;

  ///item构建列表
  final IndexedItemBuilder<T> itemBuilder;

  ///列表分页构建器
  final IndexedItemBuilder<T> separatorBuilder;

  ///列表头构建
  final ItemBuilder<List<T>> headerBuilder;

  ///构建错误布局
  final ItemBuilder loadMoreErrorViewBuilder;

  ///没有数据占位符
  ///刷新表示下拉刷新
  final Widget Function(VoidCallback refresh, BuildContext context)
      emptyBuilder;
  final ItemBuilder<List<T>> noMoreViewBuilder;
  final Widget Function(
          VoidCallback refresh, dynamic error, BuildContext context)
      initFailBuilder;
  final ScrollController scrollController;
  final LoadingState initState;
  final ScrollPhysics physics;
  final bool sliver;

  @override
  _InfiniteListViewState<T> createState() => _InfiniteListViewState<T>();
}

class _InfiniteListViewState<T> extends State<InfiniteListView<T>> {
  dynamic error;
  LoadingState state;
  bool refreshing = false;
  dynamic initError;

  bool get _hasHeader => widget.headerBuilder != null;

  @override
  void initState() {
    super.initState();
    state = widget.initState ?? LoadingState<T>();
    if (!state.initialized) {
      refresh(false);
    }
  }

  ///加载更多
  loadMore() async {
    if (state.loading) return;
    state.loading = true;
    try {
      var hasMore = await widget.onRetrieveData(
          state.currentPage + 1, state.items, false);
      if (!hasMore) {
        state.noMore = true;
      }
      error = null;
      ++state.currentPage;
    } catch (e) {
      error = e;
    } finally {
      state.loading = false;
    }
    if (mounted) {
      update();
    }
  }

  void update() {
    setState(() {});
  }

  ///下拉刷新
  Future<void> refresh(bool pillDown) async {
    if (state.loading) return;
    state.loading = true;
    state.noMore = false;
    refreshing = true;
    error = null;
    update();
    try {
      var _items = <T>[];
      var hasMore = await widget.onRetrieveData(1, _items, pillDown);
      if (_items.isEmpty ||
          _items.length % widget.pageSize != 0 && hasMore != true) {
        state.noMore = true;
      }
      state.items = _items;
      state.currentPage = 1;
    } catch (e) {
      debugPrint("infiniteListView: $e \n ${e.stackTrace}");
      if (state.currentPage == 0) {
        initError = e;
      }
    } finally {
      state.loading = false;
      refreshing = false;
    }
    if (mounted) {
      update();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (initError != null) {
      if (widget.initFailBuilder != null) {
        return widget.initFailBuilder(() {
          initError = null;
          refresh(false);
        }, initError, context);
      } else {
        return _buildInitFailedView();
      }
    }
    if (state.items.isEmpty) {
      return widget.sliver
          ? SliverFillRemaining(child: _buildInitLoadingOrErrorView(context))
          : _buildInitLoadingOrErrorView(context);
    }

    return widget.sliver ? _buildSliver() : _build();
  }

  Widget _buildInitLoadingOrErrorView(context) {
    if (state.noMore) {
      if (widget.emptyBuilder != null) {
        return widget.emptyBuilder(() => refresh(false), context);
      } else {
        return _buildEmptyView(context);
      }
    } else {
      if (widget.initLoadingBuilder != null) {
        return widget.initLoadingBuilder(context);
      } else {
        return Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        );
      }
    }
  }

  Widget _build() {
    return RefreshIndicator(
      onRefresh: () => refresh(true),
      child: ListView.builder(
        itemBuilder: _itemBuilder,
        physics: widget.physics,
        controller: widget.scrollController,
        itemCount: state.items.length + (_hasHeader ? 2 : 1),
      ),
    );
  }

  Widget _buildSliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(_itemBuilder,
          childCount: state.items.length + 1),
    );
  }

  Widget _loadingMoreView() {
    if (widget.loadingBuilder != null) {
      return widget.loadingBuilder(context);
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: SizedBox(
        width: 20.0,
        height: 20.0,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildEmptyView(context) {
    return Material(
      child: InkWell(
        splashColor: Theme.of(context).secondaryHeaderColor,
        onTap: () => refresh(false),
        child: Center(
          child: Text('No data'),
        ),
      ),
    );
  }

  Widget _buildInitFailedView() {
    return Material(
      child: InkWell(
        child: Center(
          child: Text('$initError'),
        ),
        onTap: () {
          initError = null;
          refresh(false);
        },
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (_hasHeader) {
      if (index == 0) {
        Widget header = widget.headerBuilder(state.items, context);
        if (state.loading && state.items.isEmpty) {
          header = Column(
            children: [header, _loadingMoreView()],
          );
        }
        return header;
      }
      --index;
    }
    if (index == state.items.length) {
      if (error != null) {
        Widget e;
        if (widget.loadMoreErrorViewBuilder != null) {
          e = widget.loadMoreErrorViewBuilder(error, context);
        } else {
          e = Text('Error, Click to retry!');
        }
        return Listener(
          child: Center(
            child: e,
          ),
          onPointerUp: (event) {
            setState(() {
              error = null;
              loadMore();
            });
          },
        );
      } else if (state.noMore || refreshing) {
        if (widget.noMoreViewBuilder != null) {
          return widget.noMoreViewBuilder(state.items, context);
        } else {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Total:${state.items.length}",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }
      } else {
        loadMore();
        return _loadingMoreView();
      }
    } else {
      var w = widget.itemBuilder(state.items, index, context);
      if (widget.separatorBuilder != null) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [w, widget.separatorBuilder(state.items, index, context)],
        );
      }
      return w;
    }
  }
}
