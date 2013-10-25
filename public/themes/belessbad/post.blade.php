@extends(theme_path('layout'))

@section('title')
  {{ $post->title }}
@stop

@section('content')
  <section>
    <h2 class="title">{{ $post->title }}</h2>

    <div class="date">written by {{ $post->user->first_name }} :: published {{ date("jS \of F, Y", strtotime($post->publish_date)) }}</div>
    
    {{ $post->parsed_content }}

    @include(theme_path('inc.tags'))
    
<div id="disqus_thread"></div>
<script type="text/javascript">
	var disqus_shortname = 'belessbad';
	(function() {
		var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
		dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
		(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
	})();
</script>
<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
<a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>


  </section>
@stop

