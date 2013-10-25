@extends(theme_path('layout'))

@section('content')

  <section class="page">

  <h2 class="title">{{ $post->title }}</h2>

  {{ $post->parsed_content }}
  
  </section>

@stop
