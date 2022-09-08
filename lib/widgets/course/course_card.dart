// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

// Project imports:
import '../../blocs/favorite_courses_status_bloc/favorite_courses_status_bloc.dart';
import '../../models/course_model.dart';
import 'pdf_viewer.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final int index;
  final CourseModel data;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool? fav;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 4, left: 8, top: 8),
        child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            trailing: IconButton(
              icon: Icon(
                fav != null
                    ? fav == true
                        ? LineIcons.heartAlt
                        : LineIcons.heart
                    : widget.data.fav == true
                        ? LineIcons.heartAlt
                        : LineIcons.heart,
                color: Colors.red,
              ),
              onPressed: () {
                if ((fav != null && fav == true) || (widget.data.fav == true)) {
                  context
                      .read<FavoriteCoursesStatusBloc>()
                      .add(RemoveFavorite(widget.data));
                  setState(() {
                    fav = false;
                  });
                } else {
                  context
                      .read<FavoriteCoursesStatusBloc>()
                      .add(AddFavorite(widget.data));
                  setState(() {
                    fav = true;
                  });
                }
              },
            ),
            title: Text(
              widget.data.title!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PDFViewer(
                            title: widget.data.title!,
                            url: widget.data.courseFile!,
                          )));
            }));
  }
}
