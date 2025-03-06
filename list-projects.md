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

{% assign status_groups = all_projects | group_by: "status_community" %}

<!-- Table of Projects -->
<table id="projectsTable" class="striped">
<thead>
<tr>
<th>Name</th>
<th>Description</th>
<th>Topics</th>
<th>Website</th>
<th>GitHub</th>
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
<td><a href="{{ project.url}}">{{ project.name }}</a></td>
<td>{{ project.description | default: "No description available." }}</td>
<td>{{ topics_string }}</td>
<td>
{% if project.website %}
<a href="{{ project.website }}" target="_blank" rel="noopener">Website</a>
{% else %}
{% endif %}
</td>
<td>
{% if project.gitrepo %}
<a href="{{ project.gitrepo }}" target="_blank" rel="noopener">GitHub</a>
{% else %}
{% endif %}
</td>
</tr>
{% endfor %}
</tbody>
{% endfor %}
</table>
