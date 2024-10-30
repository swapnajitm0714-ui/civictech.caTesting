---
title: Projects
layout: page
display_title: Featured Toronto Projects
permalink: "/projects/"
nav: true
---

A page about Projects -– improved introduction text and information comming soon.

We invite people from all backgrounds and skill levels to join us. Whether you're a tech expert, a curious beginner, or passionate about civic issues, your presence and contribution are valued.

[Join in by attending our Hacknights](/hacknights)

[Visit our GitHub](https://github.com/CivicTechTO)

[See Civic Tech Resources](/resources/)

## Projects

### 01. Hacknight Projects

{% assign breakout_projects = site.data.projects | where: 'breakout', 'TRUE' | sort: 'last_active' | reverse %}
<div class="grid-1">
{% for project in breakout_projects %}
    {% include project_item.html project=project %}
{% endfor %}
</div>

### 02. Other Local Projects

{% assign breakout_projects = site.data.projects | where_exp:'project', 'project.breakout == TRUE' | sort: 'last_active' | reverse %}
<div class="grid-1">
{% for project in breakout_projects %}
    {% include project_item.html project=project %}
{% endfor %}
</div>