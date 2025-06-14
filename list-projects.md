---
title: "Projects"
layout: page
permalink: "/projects/"
---

{% assign all_projects = site.projects %}

<!-- Extract unique topics -->
{% assign topic_tags = "" | split: "," %}
{% for project in all_projects %}
  {% for tag in project.tags %}
    {% if tag contains "topic/" %}
      {% assign topic_name = tag | replace: "topic/", "" | replace: "-", " " | capitalize %}
      {% assign topic_tags = topic_tags | push: topic_name %}
    {% endif %}
  {% endfor %}
{% endfor %}
{% assign unique_topics = topic_tags | uniq | sort %}

<!-- Featured Projects -->
<section>
  <header>
    <h2>Current Featured Projects</h2>
  </header>
  <p>These are some of our currently featured community projects.</p>

  <div class="card-grid">
    {% for project in all_projects %}
      {% if project.categories contains "meta/feature" %}
      <article class="card">
        <div class="card-body">
          <h3><a href="{{ project.url }}">{{ project.title }}</a></h3>
          {% if project.excerpt %}
            <p>{{ project.excerpt }}</p>
          {% endif %}
          {% if project.tags %}
            {% include topic-tags.html tags=project.tags %}
          {% endif %}
          {% if project.categories %}
            {% include namespaced-categories.html categories=project.categories namespaces="status,contributors,format" %}
          {% endif %}
        </div>
        <div class="card-footer">
          {% if project.project_website %}
            <a role="button" class="outline" href="{{ project.project_website }}" target="_blank" rel="noopener">Website</a>
          {% endif %}
          <a role="button" href="{{ project.url }}">View</a>
        </div>
      </article>
      {% endif %}
    {% endfor %}
  </div>
</section>

<!-- Breakout and Other Projects -->
{% assign breakout_projects = all_projects | where_exp: "item", "item.tags contains 'from/breakout'" %}
{% assign other_projects = all_projects | reject: "tags", "from/breakout" %}

<!-- Projects Originating from CivicTech Toronto -->
<section>
  <header>
    <h2>Projects Originating from CivicTech Toronto</h2>
  </header>
  <div class="card-list">
    {% for project in breakout_projects %}
      {% unless project.feature %}
      {% assign formatted_topics = "" | split: "," %}
      {% for tag in project.tags %}
        {% if tag contains "topic/" %}
          {% assign topic_name = tag | replace: "topic/", "" | capitalize %}
          {% assign formatted_topics = formatted_topics | push: topic_name %}
        {% endif %}
      {% endfor %}
      {% assign topics_string = formatted_topics | join: ", " %}

      <article class="card card-row filterRow" data-topics="{{ topics_string }}">
        <div class="row-content">
          <div class="row-text">
            <h3><a href="{{ project.url }}">{{ project.title }}</a></h3>
            {% if project.excerpt %}
              <p>{{ project.excerpt }}</p>
            {% endif %}
            {% if project.tags %}
              {% include topic-tags.html tags=project.tags %}
            {% endif %}
            {% if project.categories %}
              {% include namespaced-categories.html categories=project.categories namespaces="status,contributors,format" %}
            {% endif %}
          </div>
          <div class="row-actions">
            {% if project.project_website %}
              <a role="button" class="outline" href="{{ project.project_website }}" target="_blank" rel="noopener">Website</a>
            {% endif %}
            <a role="button" href="{{ project.url }}">View</a>
          </div>
        </div>
      </article>
      {% endunless %}
    {% endfor %}
  </div>
</section>

<!-- Other Community Projects -->
<section>
  <header>
    <h2>Other Community Projects</h2>
  </header>
  <div class="card-list">
    {% for project in other_projects %}
      {% unless project.feature %}
      {% assign formatted_topics = "" | split: "," %}
      {% for tag in project.tags %}
        {% if tag contains "topic/" %}
          {% assign topic_name = tag | replace: "topic/", "" | capitalize %}
          {% assign formatted_topics = formatted_topics | push: topic_name %}
        {% endif %}
      {% endfor %}
      {% assign topics_string = formatted_topics | join: ", " %}

      <article class="card card-row filterRow" data-topics="{{ topics_string }}">
        <div class="row-content">
          <div class="row-text">
            <h3><a href="{{ project.url }}">{{ project.title }}</a></h3>
            {% if project.excerpt %}
              <p>{{ project.excerpt }}</p>
            {% endif %}
            {% if project.categories %}{% include namespaced-categories.html categories=project.categories namespaces="status,contributors" %}{% endif %}
            {% if project.tags %}
              {% include topic-tags.html tags=project.tags %}
            {% endif %}
          </div>
          <div class="row-actions">
            {% if project.project_website %}
              <a role="button" class="outline" href="{{ project.project_website }}" target="_blank" rel="noopener">Website</a>
            {% endif %}
            <a role="button" href="{{ project.url }}">View</a>
          </div>
        </div>
      </article>
      {% endunless %}
    {% endfor %}
  </div>
</section>
