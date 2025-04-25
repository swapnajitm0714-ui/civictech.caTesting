---
title: "People"
layout: page
permalink: "/people/"
---

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Organizations</th>
    </tr>
  </thead>
  <tbody>
    {% assign speakers = site.people | where_exp: "person", "person.tags contains 'type/speaker'" %}
    {% for speaker in speakers %}
      <tr>
        <td>
        <a href="{{ speaker.url }}">{{ speaker.title }}</a>
        </td>
        <td>
          {% if speaker.organization %}
            {% for proj in speaker.organization %}
              {{ proj }}{% unless forloop.last %}, {% endunless %}
            {% endfor %}
          {% else %}
            –
          {% endif %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>
