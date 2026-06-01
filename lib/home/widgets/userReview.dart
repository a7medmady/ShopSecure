import 'package:e_commerce/home/model/reviewModel.dart';
import 'package:flutter/material.dart';

class UserReview extends StatelessWidget {
  final List<ReviewModel> review;
  const UserReview({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return review.isEmpty
        ? const Center(child: Text('No Review'))
        : ListView.builder(
            itemCount: review.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              List letters = review[index].reviewerName.split(' ');
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.grey,
                            child: Center(
                              child: Text('${letters[0][0]}${letters[1][0]}'),
                            ),
                          ),
                          title: Text(
                            review[index].reviewerName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  review[index].rating.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          review[index].comment,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
