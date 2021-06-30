import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeHeader extends StatelessWidget {
  final User user;
  const HomeHeader({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: HomeHeaderDelegate(user: user),
      pinned: true,
      floating: false,
    );
  }
}

class HomeHeaderDelegate implements SliverPersistentHeaderDelegate {
  final User user;

  HomeHeaderDelegate({required this.user});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(250, 250, 250, 1)),
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Hi, ${user.displayName?.split(' ')[0]}!",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Text(
              "Have a nice day!",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.black45),
            ),
          ]),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: Colors.black,
                width: 3.0,
              ),
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(user.photoURL!),
              backgroundColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration =>
      null;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;

  @override
  TickerProvider? get vsync => null;
}
