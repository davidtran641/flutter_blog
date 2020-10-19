import 'package:flutter/material.dart';
import 'package:flutter_blog/src/models/post.dart';

@immutable
class PostsState {
  final bool isError;
  final bool isLoading;
  final List<Post> posts;

  PostsState({this.isError, this.isLoading, this.posts});

  factory PostsState.inital() =>
      PostsState(isError: false, isLoading: false, posts: []);

  PostsState copyWith({
    bool isError,
    bool isLoading,
    List<Post> posts,
  }) {
    return PostsState(
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isError,
        posts: posts ?? this.posts);
  }
}
