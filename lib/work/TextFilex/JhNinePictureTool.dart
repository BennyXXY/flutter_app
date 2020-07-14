import 'package:flutter/material.dart';

import 'FadeRoute.dart';

const double itemSpace = 5.0;
const double space = 5.0; //上下左右间距

class JhNinePictureTool extends StatelessWidget {
  final List<String> imgData;
  final double lfPaddingSpace; //外部设置左右间距
  final GestureTapCallback onLongPress;

  const JhNinePictureTool(
      {Key key, this.imgData, this.lfPaddingSpace, this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var kScreenWidth = MediaQuery.of(context).size.width;
    var lfPadding = lfPaddingSpace == null ? 0.0 : lfPaddingSpace;
    var ninePictureW = (kScreenWidth - space * 2 - 2 * itemSpace - lfPadding);
    var itemWH = ninePictureW / 3;
    int columnCount = imgData.length > 6 ? 3 : imgData.length <= 3 ? 1 : 2;

    return Container(
      color: Colors.yellow,
      width: kScreenWidth - lfPadding,
      height: columnCount * itemWH + space * 2 + (columnCount - 1) * itemSpace,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: itemSpace,
              mainAxisSpacing: itemSpace),
          padding: EdgeInsets.all(space),
          itemCount: imgData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Image.network(
                  imgData[index],
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(FadeRoute(
                    page: JhPhotoAllScreenShow(
                  imgDataArr: imgData,
                  index: index,
                  onLongPress: onLongPress,
                )));
              },
            );
          }),
    );
  }
}
