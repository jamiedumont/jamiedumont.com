+++
title = "The Last Straw"
description = """\
    When a regular expression failed to work as expected I almost \ 
    renounced software development entirely. Warning: this post contains a vent.\
"""
+++

It was a regular expression that drove me over the edge.
I'm sure I'm not the first developer to be defeated by these horrific things,
and I certainly won't be the last. The difference was that I knew I was right — 
something that is never a given with RegEx!

Normally the process of writing a regular expression starts with taking a best guess,
failing, realising why it's failing, fix it, still failing, realise why it's failing,
fix it, etc. It's a process filled with a lot of little moments of schadenfreude. This was different.

I've been working out how to write the first plugin whilst trialling [Publish](https://github.com/JohnSundell/Publish).
I needed to breakdown a line of text in a known format, pulling out the
different scraps of information to later convert into an image gallery.

The expression was complex but also simple once you looked at it properly
from behind your fingers (RegEx invokes a *"fight-or-flight"* response in most developers).

```re

  ^[-\*] \$image_row\!\[(?<alt>[^{}]*)\]\((?<path>[^{}]+)\)$

```
...should match...
```yaml

  - $image_row![My alt text here](/the/path/to/the/image.jpg)

```
...extracting the alt text and the path to the image file. Simple huh?

Well, this was my first time working with regular expressions in Swift, and it wasn't working at all. I was sure I had made a mistake — mistakes are just part of writing a regular expression after all — but every program and tester confirmed it was correct. Still, the `b\*$t\*^d` thing wouldn't work in my plugin!

It transpires that Swift uses [NSRegularExpression](https://developer.apple.com/documentation/foundation/nsregularexpression) which *"conforms to the International Components for Unicode (ICU) specification for regular expressions"*. What the **<strong>**hell**</strong>** is *that?!*

It turns out to be a different specification for regular expressions that I've never heard of. It seemed to share all the operators of PCRE and Javascript regular expressions so I was still left confused as to why mine wasn't working.

After more hours Googling than I care to admit, I came up with...

```re

  ^[-\\*] \\$image_row\\!\\[(?<alt>[^{}]*)\\]\\((?<path>[^{}]+)\\)$

```
...which the keen-eyed RegEx connoisseurs will notice has extra escaping \ characters. Why these are necessary is anyones guess, because they aren't mentioned in the specification, but I'm sure someone knows.

As for me, it just highlighted why I'm making the shift from programming to photography. These paper-cut bug hunts are the equivalent of leaving your lens cap on, except that I can guarantee you'll only make that particular mistake once, whereas this kind of bug hunt is a daily occurrence.

## How this all came to be

All I was trying to do was convert the following (invalid) markdown...


```yaml

  - $image_row![My alt text here](/the/path/to/the/image.jpg)
  - $image_row![Second image](/the/path/to/the/image.jpg)
  - $image_row![Third image alt text](/the/path/to/the/image.jpg)

```


...into...


```html

  <div class="image_row">
    <img alt="My alt text here" src="/the/path/to/the/image.jpg" />
    <img alt="Second image" src="/the/path/to/the/image.jpg" />
    <img alt="Third image alt text" src="/the/path/to/the/image.jpg" />
  </div>

```

What's wrong with just writing the HTML? Admittedly there was going to be another plugin to produce proper `<picture>` tags with responsive images, but that's by-the-by. I was making the classic developer mistake of trying to automate something that was easier to just do "the hard way".

It also dangled a tantalising question in front of me. What if I just wrote all my content as HTML and forgo any templating and plugins? It might be slower writing an individual page, but what about all the time I saved not dicking about with all the frustrations of modern web development? The result would be truly future-proof and wouldn't require that I stay current on whatever language or framework is building the site. I wouldn't need to manage dependencies or development environments.

Of course there's huge drawbacks such as manually needing to format code snippets, producing images in different formats and resolutions, managing shared HTML across pages, maintaining indexes such as RSS feeds, sitemaps and lists of recent posts on the homepage. The list goes on. Be that as it may...it's tempting!


