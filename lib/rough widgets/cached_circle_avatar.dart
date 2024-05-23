class CachedCircleAvatar extends StatelessWidget {
  const CachedCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey[200],
      child: CachedNetworkImage(
        imageUrl: _homeController
            .usersList[idx].userImage
            .toString(),
        imageBuilder:
            (context, imageProvider) =>
            CircleAvatar(
              radius: 60,
              backgroundImage: imageProvider,
            ),
        placeholder: (context, url) =>
            SizedBox(
              width: 120, // Adjust to match the CircleAvatar radius, double the radius
              height: 120,
              child:
              const CircularProgressIndicator(),
            ),
        errorWidget:
            (context, url, error) =>
            CircleAvatar(
              radius: 60,
              child: const Icon(Icons.error),
            ),
      ),
    ),;
  }
}
