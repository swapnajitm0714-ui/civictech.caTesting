---
title: "People"
layout: page
permalink: "/people/"
---

{% assign all_people = site.people %}

<!-- Extract unique categories -->
{% assign all_categories = "" | split: "," %}
{% for person in all_people %}
  {% for category in person.categories %}
    {% assign category_name = category | downcase %}
    {% unless all_categories contains category_name %}
      {% assign all_categories = all_categories | push: category_name %}
    {% endunless %}
  {% endfor %}
{% endfor %}
{% assign unique_categories = all_categories | uniq | sort %}

<!-- Display People grouped by Category -->

{% for category in unique_categories %}
<section>
  <header>
    <h2>{{ category | capitalize }}s</h2> 
  </header>

  <div class="card-list">
    {% for person in all_people %}
      {% if person.categories contains category %}
      <article class="card card-row">
        <div class="row-content">
          <div class="row-text">
            <h3><a href="{{ person.url }}">{{ person.title }}</a></h3>

            {% if person.organization %}
              <p>
                <small>
                  Affiliated with: 
                  {% for org in person.organization %}
                    {{ org | remove: '[[' | remove: ']]' }}{% unless forloop.last %}, {% endunless %}
                  {% endfor %}
                </small>
              </p>
            {% endif %}

            {% if person.tags %}
              {% include topic-tags.html tags=person.tags %}
            {% endif %}
          </div>

          <div class="row-actions">
            <a role="button" href="{{ person.url }}">View</a>
          </div>
        </div>
      </article>
      {% endif %}
    {% endfor %}
  </div>
</section>
{% endfor %}
