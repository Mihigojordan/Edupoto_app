import 'package:flutter/material.dart';

class ImagesUp extends StatelessWidget {
  final String questionText;
  const ImagesUp(this.questionText, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ],
          image: DecorationImage(
            image: AssetImage(questionText),
            fit: BoxFit.cover,
            scale: 5.0,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
    );
  }
}

class ButtonImages extends StatelessWidget {
  final String questionText;
  const ButtonImages(this.questionText, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(questionText),
          fit: BoxFit.fill,
          scale: 5.0,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }
}

class SmallImages extends StatelessWidget {
  final String questionText;
  const SmallImages(this.questionText, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ],
          image: DecorationImage(
            image: AssetImage(questionText),
            fit: BoxFit.fill,
            scale: 5.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(1))),
    );
  }
}

class SmallNImages extends StatelessWidget {
  final String questionText;
  const SmallNImages(this.questionText, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image.network(
      'https://i.pinimg.com/736x/92/b8/95/92b8957afb54f71591f92d60fdaaaa51.jpg',
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}

class IconImages extends StatelessWidget {
  final String questionText;
  const IconImages(this.questionText, {super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(questionText),
          fit: BoxFit.fill,
          scale: 5.0,
        ),
      ),
    );
  }
}
