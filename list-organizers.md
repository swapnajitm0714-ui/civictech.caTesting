---
title: "Organizers"
layout: page
permalink: "/about-us/organizers/"
---

Civic Tech Toronto thrives due to the participation of its community. Click here for a list of community members who make up Civic Tech Toronto.

Below is a list of our volunteer organizers. Please feel free to reach out to any of us at our weekly hacknights, on our slack channel (get your Slack invite here). You can also connect with the volunteers on our social channels below. Finally, you can always drop us a line at hi@civictech.ca

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Projects</th>
    </tr>
  </thead>
  <tbody>
    {% assign organizers = site.people | where_exp: "person", "person.tags contains 'type/organizer'" %}
    {% for organizer in organizers %}
      <tr>
        <td><strong>{{ organizer.name }}</strong></td>
        <td>
          {% if organizer.project %}
            {% for proj in organizer.project %}
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
