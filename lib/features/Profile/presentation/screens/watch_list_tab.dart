import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/Movie_details/presentation/screens/movie_details_screen.dart';
import 'package:movieapp/features/Profile/data/models/whatch_list_response_data.dart';
import 'package:movieapp/features/Profile/presentation/cubit/watch_cubit.dart';
import 'package:movieapp/features/Profile/presentation/cubit/watchstate.dart';
import 'package:movieapp/theme/apptheme.dart';

class WatchListTab extends StatefulWidget {
  final Function(int) onWatchListUpdated;

  const WatchListTab(
      {super.key, required this.onWatchListUpdated}); // Callback Function

  @override
  _WatchListTabState createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  List<WhatchListResponseData> watchList = [];

  @override
  void initState() {
    super.initState();
    final state = context.read<WatchCubit>().state;
    if (state is AuthSuccess) {
      watchList = List.from(state.data.data ?? []);
      widget.onWatchListUpdated(watchList.length);
    }
  }

  void removeMovie(int index) async {
    final removedMovie = watchList[index];
    final watchCubit = context.read<WatchCubit>();

    setState(() {
      watchList.removeAt(index);
      widget.onWatchListUpdated(watchList.length);
    });

    bool isDeleted =
        await watchCubit.deleteWatchList(int.parse(removedMovie.movieId!));
    if (!isDeleted) {
      setState(() {
        watchList.insert(index, removedMovie);
        widget.onWatchListUpdated(watchList.length);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ أثناء الحذف، حاول مرة أخرى")),
      );
    }
  }

  Future<void> refreshWatchList() async {
    await context.read<WatchCubit>().getWatchList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          setState(() {
            watchList = List.from(state.data.data ?? []);
          });
        }
        widget.onWatchListUpdated(watchList.length);
      },
      child: RefreshIndicator(
        color: AppTheme.primary,
        backgroundColor: AppTheme.black,
        onRefresh: () async {
          await refreshWatchList();
          widget.onWatchListUpdated(watchList.length);
        },
        child: watchList.isEmpty
            ? Center(child: Image.asset("assets/images/profile.png"))
            : Column(
                children: watchList.map((movie) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetailsScreen(id: int.parse(movie.movieId!)),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Card(
                        color: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              movie.imageUrl ?? "",
                              width: 60,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.image_not_supported,
                                      color: Colors.grey),
                            ),
                          ),
                          title: Text(
                            movie.name ?? "اسم غير معروف",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "⭐ ${movie.rating ?? 'غير متوفر'} | 📅 ${movie.year ?? 'غير متوفر'}",
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          trailing: IconButton(
                            onPressed: () =>
                                removeMovie(watchList.indexOf(movie)),
                            icon: Icon(Icons.bookmark_rounded,
                                size: 30, color: AppTheme.white),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
