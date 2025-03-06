---
title: "Hacknights"
layout: page-wide
permalink: "/hacknights/"
---

{% assign all_events = site.hacknights | sort: "date" | reverse %}

<!-- Extract unique topics -->

{% assign topic_tags = "" | split: "," %}
{% for event in all_events %}
{% for tag in event.tags %}
{% if tag contains "topic/" %}
{% assign topic_name = tag | replace: "topic/", "" | replace: "-", " " | capitalize %}
{% assign topic_tags = topic_tags | push: topic_name %}
{% endif %}
{% endfor %}
{% endfor %}
{% assign unique_topics = topic_tags | uniq | sort %}

{% include filter.html
type="hacknights"
search_id="searchHacknights"
table_id="hacknightsTable"
filter_id="hacknightFilters"
checkbox_class="hacknightCheckbox"
unique_topics=unique_topics
%}

<!-- Group Events by Year -->

{% assign events_by_year = all_events | group_by_exp: "event", "event.date | date: '%Y'" %}

<table id="hacknightsTable" class="striped">
<thead>
<tr>
<th>Date</th>
<th>Title</th>
<th>Speakers</th>
<th>Topics</th>
<th>Event Link</th>
</tr>
</thead>

{% for year_group in events_by_year %}

<tbody>
<tr>
<th scope="rowgroup" colspan="5"><strong>{{ year_group.name }}</strong></th>
</tr>

{% for event in year_group.items %}
{% assign formatted_topics = "" | split: "," %}
{% for tag in event.tags %}
{% if tag contains "topic/" %}
{% assign topic_name = tag | replace: "topic/", "" | replace: "-", " " | capitalize %}
{% assign formatted_topics = formatted_topics | push: topic_name %}
{% endif %}
{% endfor %}
{% assign topics_string = formatted_topics | join: ", " %}

<tr class="filterRow" data-topics="{{ topics_string }}">
<td>{{ event.date | date: "%B %d, %Y" }}</td>
<td><a href="{{ event.url }}" >{{ event.title }}</a></td>
<td>{{ event.speakers | join: ", " }}</td>
<td>{{ topics_string }}</td>
<td>
{% if event.eventUrl %}
<a href="{{ event.eventUrl }}" target="_blank" rel="noopener">Meetup Link</a>
{% else %}
N/A
{% endif %}
</td>
</tr>
{% endfor %}
</tbody>
{% endfor %}
</table>
