import 'package:flutter/material.dart';
import 'package:flutter_blog/src/models/post.dart';
import 'package:flutter_blog/src/redux/posts/posts_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'src/redux/store.dart';
import 'package:redux/redux.dart';

void main() async {
  final redux = Redux();
  await redux.init();
  runApp(MyApp(redux: redux));
}

class MyApp extends StatelessWidget {
  final Redux redux;
  MyApp({Key key, @required this.redux}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StoreProvider<AppState>(
        store: redux.store,
        child: MyHomePage(title: "My Blog",),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StoreConnector<AppState, MyHomePageViewModel>(
        distinct: true,
        converter: (store) => MyHomePageViewModel.make(store),
        builder: (context, viewModel) {
          return Column(
            children: [
              RaisedButton(
                child: Text('Fetch Posts'),
                onPressed: viewModel.onPressed,
              ),
              _buildLoading(viewModel),
              Expanded(child: _buildListView(viewModel),)
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoading(MyHomePageViewModel viewModel) {
    if (viewModel.isLoading) {
      return CircularProgressIndicator();
    } else if (viewModel.isError){
      return Text('Failed to get posts');
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildListView(MyHomePageViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.posts.length,
      itemBuilder: (context, index) {
        var post = viewModel.posts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.body),
          key: Key(post.id.toString()),
        );
      }
    );
  }
}

class MyHomePageViewModel {
  Function onPressed;
  bool isError;
  bool isLoading;
  List<Post> posts;

  MyHomePageViewModel({this.isError, this.isLoading, this.posts, @required this.onPressed});

  factory MyHomePageViewModel.make(Store<AppState> store) {
    return MyHomePageViewModel(
      isError: store.state.postsState.isError,
      isLoading: store.state.postsState.isLoading,
      posts: store.state.postsState.posts,
      onPressed: () {
      store.dispatch(fetchPostsAction);
    });
  }
}
