/*
class ErrorScreen extends StatelessWidget {
  final void Function() onPressed;
  const ErrorScreen({Key? key,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModel=Provider.of<ThemeModel>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isPortrait = MediaQuery.of(context).orientation==Orientation.portrait;

    return  Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/error.svg",
              height: isPortrait ? width*0.4:height*0.3,
            ),
            Padding(padding:const  EdgeInsets.only(
                top: 10
            ),
              child: Text(AppLocalizations.of(context)!.there_is_an_error,
                style: themeModel.theme.textTheme.headline5!.apply(
                    color: Colors.red
                ),),),

            Padding(
              padding:const  EdgeInsets.only(
                  top: 5
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red
                ),
                onPressed:onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(Icons.refresh),
                      Padding(padding: const EdgeInsetsDirectional.only(start: 5),
                        child: Text(AppLocalizations.of(context)!.reload),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/