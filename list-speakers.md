---
title: "Speakers"
layout: page
permalink: "/speakers/"
---

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Hacknights</th>
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
          {% if speaker.project %}
            {% for proj in speaker.project %}
              {{ proj }}{% unless forloop.last %}, {% endunless %}
            {% endfor %}
          {% else %}
            N/A
          {% endif %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>
