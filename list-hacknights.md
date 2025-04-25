---
title: "Hacknights"
layout: page
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
<th>Hacknight</th>
<th>Links</th>
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

{% assign speakers_text_array = "" | split: "" %}
{% for speaker in event.speakers %}
{% assign speaker_string = speaker | remove: '[[' | remove: ']]' %}
{% assign speakers_text_array = speakers_text_array | push: speaker_string %}
{% endfor %}

{% assign topics_string = formatted_topics | join: ", " %}

<tr class="filterRow" data-topics="{{ topics_string }}">
<td>
  <small>{{ event.date | date: "%B %d, %Y" }}</small><br/>
  <a href="{{ event.url }}" >{{ event.title }}</a><br/>
  {% if speakers_text_array.size > 0 %}
    <p>with {{ speakers_text_array | join: ", " }}</p>
  {% endif %}
  {% if topics_string.size > 0 %}
    <small>Topics: {{ topics_string }}</small>
  {% endif %}
</td>
<td>
<div role="group">
{% if event.eventUrl %}
<a role="button" class="outline" href="{{ event.eventUrl }}" target="_blank" rel="noopener">Event&nbsp;Link</a>
{% endif %}
<a role="button" href="{{ event.url }}" target="_blank" rel="noopener">View</a>
</div>
</td>
</tr>
{% endfor %}
</tbody>
{% endfor %}
</table>
