---
title: "Resources"
layout: page
permalink: "/resources/"
---

{% assign all_resources = site.resources %}

<!-- Extract unique topics -->

{% assign topic_tags = "" | split: "," %}
{% for resource in all_resources %}
{% for tag in resource.tags %}
{% if tag contains "topic/" %}
{% assign topic_name = tag | replace: "topic/", "" | replace: "-", " " | capitalize %}
{% assign topic_tags = topic_tags | push: topic_name %}
{% endif %}
{% endfor %}
{% endfor %}
{% assign unique_topics = topic_tags | uniq | sort %}

<!-- Include the reusable filtering component -->

{% include filter.html
type="resources"
search_id="searchResources"
table_id="resourcesTable"
filter_id="resourceFilters"
checkbox_class="resourceCheckbox"
unique_topics=unique_topics
%}

<!-- Organizing Resources by Categories -->

{% assign type_tags = "" | split: "," %}
{% for resource in all_resources %}
{% for tag in resource.tags %}
{% if tag contains "type/" %}
{% assign type_tags = type_tags | push: tag %}
{% endif %}
{% endfor %}
{% endfor %}
{% assign unique_types = type_tags | uniq | sort %}

<!-- Creating hierarchical structure -->

{% assign categories = "" | split: "," %}
{% assign subcategories = "" | split: "," %}

{% for type in unique_types %}
{% assign parts = type | split: "/" %}
{% assign category = parts[1] %}
{% assign subcategory = parts[2] %}

{% unless categories contains category %}
{% assign categories = categories | push: category %}
{% endunless %}

{% if subcategory %}
{% assign subcategories = subcategories | push: type %}
{% endif %}
{% endfor %}

<!-- Table of Resources -->
<table id="resourcesTable" class="striped">
<thead>
<tr>
<th>Resource</th>
<th>Url</th>
</tr>
</thead>

{% for category in categories %}

<tbody>
<tr>
<th scope="rowgroup" colspan="6"><strong>{{ category | replace: "-", " " | capitalize }}</strong></th>
</tr>

{% for sub in subcategories %}
{% assign parts = sub | split: "/" %}
{% assign parent_category = parts[1] %}
{% assign sub_category = parts[2] %}

{% if parent_category == category %}
{% for resource in all_resources %}
{% if resource.tags contains sub %}
{% assign formatted_topics = "" | split: "," %}
{% for tag in resource.tags %}
{% if tag contains "topic/" %}
{% assign topic_name = tag | replace: "topic/", "" | replace: "-", " " | capitalize %}
{% assign formatted_topics = formatted_topics | push: topic_name %}
{% endif %}
{% endfor %}
{% assign topics_string = formatted_topics | join: ", " %}

<tr class="filterRow" data-topics="{{ topics_string }}">
<td>
  <small>{{ category | replace: "-", " " | capitalize }} > {{ sub_category | replace: "-", " " | capitalize }}</small><br/>
  <strong>{{ resource.title }}</strong> – {{ resource.description | default: "" }}<br/>
  {% if topics_string %}
  <small>Topics: {{ topics_string }}</small>
  {% endif %}
  </td>
<td>
{% if resource.website %}
<a href="{{ resource.website }}" target="_blank" rel="noopener">{{ resource.website }}</a>
{% endif %}
</td>
</tr>
{% endif %}
{% endfor %}
{% endif %}
{% endfor %}

<!-- Add resources without subcategories -->

{% for resource in all_resources %}
{% assign expected_tag = "type/" | append: category %}
{% if resource.tags contains expected_tag %}
{% assign formatted_topics = "" | split: "," %}
{% for tag in resource.tags %}
{% if tag contains "topic/" %}
{% assign topic_name = tag | replace: "topic/", "" | replace: "-", " " | capitalize %}
{% assign formatted_topics = formatted_topics | push: topic_name %}
{% endif %}
{% endfor %}
{% assign topics_string = formatted_topics | join: ", " %}

<tr class="filterRow" data-topics="{{ topics_string }}">
<td>
  <small>{{ category | replace: "-", " " | capitalize }}</small><br/>
  <strong>{{ resource.title }}</strong> – {{ resource.description | default: "" }}<br/>
  {% if topics_string %}
  <small>Topics: {{ topics_string }}</small>
  {% endif %}
</td>
<td>
{% if resource.website %}
<a href="{{ resource.website }}" target="_blank" rel="noopener">{{ resource.website }}</a>
{% endif %}
</td>
</tr>
{% endif %}
{% endfor %}
</tbody>
{% endfor %}
</table>
