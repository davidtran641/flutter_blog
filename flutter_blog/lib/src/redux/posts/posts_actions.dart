import 'package:flutter/material.dart';
import 'package:flutter_blog/src/models/post.dart';
import 'package:flutter_blog/src/redux/posts/posts_state.dart';
import 'package:redux/redux.dart';
import '../store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@immutable
class SetPostsStateAction {
  final PostsState postsState;
  SetPostsStateAction(this.postsState);
}

Future<void> fetchPostsAction(Store<AppState> store) async {
  store.dispatch(SetPostsStateAction(PostsState(isLoading: true)));

  try {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode != 200) {
      store.dispatch(
          SetPostsStateAction(PostsState(isError: true, isLoading: false)));

      return;
    }
    final json = jsonDecode(response.body);
    store.dispatch(
      SetPostsStateAction(
        PostsState(isLoading: false, isError: false, posts: Post.listFromJson(json))
    ));

    
  } catch (error) {
    store.dispatch(SetPostsStateAction(PostsState(isLoading: false,  isError: true)));
  }
}
