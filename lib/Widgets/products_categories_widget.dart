import 'package:flutter/material.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Models/categories_model.dart';

class ProductsCategoriesWidget extends StatelessWidget {
  const ProductsCategoriesWidget({Key? key, required this.data}) : super(key: key);
final List<Data> data;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Image(
            //   image: NetworkImage(
            //     '${data[index].image}',
            //   ),
            //   height: 100,
            //   width: 100,
            //   fit: BoxFit.fill,
            // ),
            fadeInImage(networkImagePath: '${data[index].image}', width: 100, height: 100, fit: BoxFit.fill,),
            Container(
              width: 100,
              color: Colors.black54,
              padding: const EdgeInsets.all(5),
              child: Text(
                '${data[index].name}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: data.length,
      ),
    );
  }
}
