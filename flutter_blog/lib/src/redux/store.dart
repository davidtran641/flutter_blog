
import 'package:flutter/material.dart';
import 'package:flutter_blog/src/redux/posts/posts_actions.dart';
import 'package:flutter_blog/src/redux/posts/posts_reducer.dart';
import 'package:flutter_blog/src/redux/posts/posts_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class AppState {
  final PostsState postsState;

  AppState({
    @required this.postsState
  });

  AppState copyWith({
    PostsState postsState
  }) {
    return AppState(postsState: postsState ?? this.postsState);
  }
}

AppState appReducer(AppState state, dynamic action) {
  if(action is SetPostsStateAction) {
    final nextPostsState = postReducer(state.postsState, action);
    return state.copyWith(postsState: nextPostsState);
  }
  return state;
}

class Redux {
  Store<AppState> _store;

  Store<AppState> get store {
    return _store;
  }

  Future<void> init() async {
    final postsState = PostsState.inital();
    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(postsState: postsState)
    );
  }
}


