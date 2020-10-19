import 'package:flutter_blog/src/redux/posts/posts_actions.dart';
import 'package:flutter_blog/src/redux/posts/posts_state.dart';

postReducer(PostsState state, SetPostsStateAction action) {
  final payload = action.postsState;
  return state.copyWith(
      isError: payload.isError,
      isLoading: payload.isLoading,
      posts: payload.posts);
}
