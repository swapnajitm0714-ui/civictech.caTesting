---
title: "Projects"
layout: page
permalink: "/projects/"
---

{% assign breakout_projects = site.projects | where: "fromBreakout", true %}
{% assign non_breakout_projects = site.projects | where: "fromBreakout", false %}

{% assign grouped_breakout_projects = breakout_projects | group_by: "status_community" | sort: "name" %}
{% assign grouped_non_breakout_projects = non_breakout_projects | group_by: "status_community" | sort: "name" %}

  <section>
    <h2>Breakout Projects</h2>
    {% if grouped_breakout_projects.size > 0 %}
      {% for group in grouped_breakout_projects %}
        <h3>{{ group.name | capitalize }}</h3>
        <ul>
          {% for project in group.items %}
            <li>
              <a href="{{ project.url }}">{{ project.name }}</a>
              {% if project.tags %}
                <small>
                  {% for tag in project.tags %}
                    <span class="tag">{{ tag | replace: "type/", "" | replace: "topic/", "" }}</span>
                  {% endfor %}
                </small>
              {% endif %}
            </li>
          {% endfor %}
        </ul>
      {% endfor %}
    {% else %}
      <p>No breakout projects found.</p>
    {% endif %}
  </section>

  <section>
    <h2>Regional Projects</h2>
    {% if grouped_non_breakout_projects.size > 0 %}
      {% for group in grouped_non_breakout_projects %}
        <h3>{{ group.name | capitalize }}</h3>
        <ul>
          {% for project in group.items %}
            <li>
              <a href="{{ project.url }}">{{ project.name }}</a>
              {% if project.tags %}
                <small>
                  {% for tag in project.tags %}
                    <span class="tag">{{ tag | replace: "type/", "" | replace: "topic/", "" }}</span>
                  {% endfor %}
                </small>
              {% endif %}
            </li>
          {% endfor %}
        </ul>
      {% endfor %}
    {% else %}
      <p>No general projects found.</p>
    {% endif %}
  </section>
