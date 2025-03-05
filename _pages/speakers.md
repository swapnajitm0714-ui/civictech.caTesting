---
title: "Speakers"
layout: base
permalink: "/cat_speakers/"
---

## Speakers List

<ul>
  {% for speaker in site.speakers %}
    <li><a href="{{ speaker.url }}">{{ speaker.title }}</a></li>
  {% endfor %}
</ul>
