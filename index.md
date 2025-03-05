---
title: "Home"
---

<section>
<hgroup>
<h1>Hacknights for everyone.</h1>
<p>Every Tuesday from 7pm to 9pm.</p>
</hgroup>
<div class="grid">
<figure>
  <img
    src="assets/images/CivicTechTO-compressed-1020x615-1.jpg"
    alt="screenshot of a Zoom call with participants waving at the fifth anniversary of Civic Tech"
  />
  <figcaption>
    Fifth Anniversary of Civic Tech
  </figcaption>
</figure>
<div>
<p>Civic Tech Toronto is a vibrant and diverse community of Torontonians engaged in understanding and creating solutions for civic challenges through technology, design, and other innovative means.</p>
<p>We now run our Hacknights in a hybrid format, welcoming both online and in-person participation every Tuesday from 7pm to 9pm. At these Hacknights, members of the community gather to hear from inspiring speakers, share and learn about civic tech stories, and collaborate on projects aimed at improving Toronto.</p>
<button>View Upcoming Hacknights</button>
<button class="secondary">Past Hacknights</button>
</div>
</div>
</section>

<section>
  <h1>Who's Invited</h1>
  <p>We invite people from all backgrounds and skill levels to join us. Whether you’re a tech expert, a curious beginner, or passionate about civic issues, your presence and contribution are valued.</p>
  <p>Civic Tech Toronto is committed to fostering a safe, inclusive, and enjoyable environment for collaboration. We believe in the power of diverse perspectives and a human-centred approach in tackling civic issues, leading to remarkable outcomes.</p>
  <button class="secondary">Code of Conduct</button>
</section>

<section>
  <hgroup>
  <h1>What to Expect</h1>
  <p>A typical Tuesday evening Hacknight</p>
  </hgroup>
  <div class="grid">
    <div>
      <figure>
        <img
          src="assets/images/icon-happy-speech-bubble.png"
          alt="socializing icon"
        />
        <figcaption>
          7:00 pm - Introductions to each other and Civic Tech Toronto
        </figcaption>
      </figure>
    </div>
    <div>
          <figure>
        <img
          src="assets/images/icon-podium.png"
          alt="presentation icon"
        />
        <figcaption>
          7:20 pm - Scheduled speaker presents to the group
        </figcaption>
      </figure>
    </div>
    <div>
          <figure>
        <img
          src="assets/images/icon-collaboration.png"
          alt="collaboration icon"
        />
        <figcaption>
          7:50 pm - Attendees collaborate on projects
        </figcaption>
      </figure>
    </div>
  </div>
</section>
<section>
<hgroup>
<h1>Past Speakers</h1>
Some of our past hacknight speakers
</hgroup>

- Ryan Androsoff Treasury Board of Canada
- Vasiliki Bednar Youth Employment Panel
- Dave Biggs MetroQuest
- Hillary Hartley Ontario Digital Service
- Tris Lumley New Philanthropy Capital
- Jean-Noe Landry Open North
- Jane Hilderman Samara
- Jesse Coleman City of Toronto
- Jennifer Hollett Atkinson Foundation
- Jolene Cushman Toronto Environmental Alliance
- Judy Duncan ACORN
- Liane Fernandes LHIN
- Jessica Smith Cross Torontoist
- Jay Wall Studio Jaywall
- Andy Best City of Guelph
- Monique Baena-Tan Code for America
- Christien Levien LegalSwipe
- Mayaan Ziv AccessNow

<div class="speakers-grid">
  {% for speaker in site.speakers limit:18 %}
    <div>
      <p>{{ speaker.name }}</p>
      <p>{{ speaker.description }}</p>
    </div>
  {% endfor %}
</div>

<button>See all past speakers here!</button>

</section>

<section>
<h1>Our supporters</h1>
</section>
