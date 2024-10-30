---
layout: page
title: Previous Hacknights
permalink: /hacknights/previous/
---

A list of previous hacknights ported over from the wordpress.

{% assign posts = site.posts %}

{%- if posts.size > 0 -%}
{%- if page.list_title -%}
    <h2 class="post-list-heading">{{ page.list_title }}</h2>
{%- endif -%}
<ul class="post-list">
    {%- assign date_format = site.minima.date_format | default: "%b %-d, %Y" -%}
    {%- for post in posts -%}
    <li>
    <span class="post-meta">{{ post.date | date: date_format }}</span>
        <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a>
    {%- if site.show_excerpts -%}
        {{ post.excerpt }}
    {%- endif -%}
    </li>
    {%- endfor -%}
</ul>
{%- endif -%}