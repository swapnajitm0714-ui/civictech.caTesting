---
title: "Projects"
layout: page
permalink: "/projects/"
---

<!-- FEATURED PROJECTS -->

<section>
<header>
<h2>Current Projects</h2>
</header>
<p>These are some of are current community projects.</p>

<div style="
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
">
{% for project in site.projects %}
  {% if project.feature == true %}
  <article>
    <h3><a href="{{ project.url }}">{{ project.title }}</a></h3>
    <p>{{ project.excerpt }}</p>
    {% if project.tags %}
    {% include topic-tags.html tags=project.tags %}
    {% endif %}
    <div role="group">
      {% if project.project_website %}
      <a role="button" class="outline" href="{{ project.project_website }}" target="_blank">Website</a>
      {% endif %}
      <a role="button" href="{{ project.url }}">View</a>
    </div>
  </article>
  {% endif %}
{% endfor %}
</div>
</section>


<!-- ALL PROJECTS -->

<section>
<header>
<h2>All Projects</h2>
</header>

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


<!-- Include the reusable filtering component -->

{% include filter.html
type="projects"
search_id="searchProjects"
table_id="projectsTable"
filter_id="projectFilters"
checkbox_class="projectCheckbox"
unique_topics=unique_topics
%}

<!-- Organizing Projects by Status -->

{% assign status_groups = all_projects | group_by: "status_project" %}

<!-- Table of Projects -->
<table id="projectsTable" class="striped">
<thead>
<tr>
<th>Project</th>
<th>Status</th>
<th>Links</th>
</tr>
</thead>

{% for status_group in status_groups %}

<tbody>
<tr>
<th scope="rowgroup" colspan="5"><strong>Status: {{ status_group.name | capitalize }}</strong></th>
</tr>

{% for project in status_group.items %}
{% assign formatted_topics = "" | split: "," %}
{% for tag in project.tags %}
{% if tag contains "topic/" %}
{% assign topic_name = tag | replace: "topic/", "" | replace: "-", " " | capitalize %}
{% assign formatted_topics = formatted_topics | push: topic_name %}
{% endif %}
{% endfor %}
{% assign topics_string = formatted_topics | join: ", " %}

<tr class="filterRow" data-topics="{{ topics_string }}">
<td>
{% if project.fromBreakout == True %}✨{% endif %}
<a href="{{ project.url }}">{{ project.title }}</a>
{% if project.excerpt %}
<br/>{{ project.excerpt }}
{% endif %}
{% if project.tags %}
<br/>
  {% include topic-tags.html tags=project.tags%}
{% endif %}
</td>
<td>
 {{ project.status_project }}
</td>
<td>
<div role="group">
{% if project.website %} <a role="button" class="outline" href="{{ project.website }}" target="_blank" rel="noopener">Website</a> {% else %} {% endif %} <a role="button"  href="{{ project.url }}">View</a>
</div>
</td>
</tr>
{% endfor %}
</tbody>
{% endfor %}
</table>

</section>