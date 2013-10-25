<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>@yield('title')</title>
    <link href='//fonts.googleapis.com/css?family=OFL+Sorts+Mill+Goudy+TT' rel='stylesheet' type='text/css'/>
    <link href="{{ url(theme_path('css/style.css')) }}" rel="stylesheet" media="screen">
  </head>
  <body>
    <div class="container">
      <header>
        <h1><a href="{{ url('/') }}">{{ site_title() }}</a></h1>
        <nav>
          <ul>
            <li><a href="{{ url('archive') }}">Posts</a></li>
            <li><a href="{{ url('about-us') }}">About</a></li>
            <li><a href="{{ url('rss') }}">RSS</a></li>
          </ul>
        </nav>
      </header>
      <div class="content">
        @yield('content')
      </div>
      <div class="sidebar">

        <div class="about-box">

        <h3>About the site</h3>

        <p class="small">BeLessBad aims to advocate by negativity, to name and shame bad processes and practises to encourage good ones.</p>

        <p class="small">The PHP community is littered with people doing some very dumb things, for some really stupid reasons. If the language is to evolve and improve, we need to clean house.</p>

        <p class="small">If you want some less obnoxious disussion of PHP best practises, try <a href="http://www.phptherightway.com">PHP: The Right Way</a></p>

        </div>

        <script type="text/javascript" src="http://belessbad.disqus.com/recent_comments_widget.js?num_items=25&hide_avatars=0&avatar_size=40&excerpt_length=200"></script>
        
      </div>

      <div style="clear: both;"></div>

      <footer>
        <p>Powered by <a href="http://wardrobecms.com">Wardrobe</a></p>
      </footer>
    </div>


    <script type="text/javascript">
    var disqus_shortname = 'belessbad';

    (function () {
    var s = document.createElement('script'); s.async = true;
    s.type = 'text/javascript';
    s.src = 'http://' + disqus_shortname + '.disqus.com/count.js';
    (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
    }());
    </script>


    <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-43239076-1', 'belessbad.com');
  ga('send', 'pageview');

</script>
  </body>
</html>
