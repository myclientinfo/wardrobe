<div class="post">


  <h2><a href="{{ url('post/'.$post->slug) }}">{{ $post->title }}</a></h2>
  <div class="date">written by {{ $post->user->first_name }} :: published {{ date("jS \of F, Y", strtotime($post->publish_date)) }}</div>
  <div class="post-content">
    {{ $post->parsed_content }}
  </div>
  <a href="{{ url('post/'.$post->slug) }}#disqus_thread">{{ $post->title }}</a>
</div>