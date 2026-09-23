const $ = (selector) => document.querySelector(selector);
const api = "/api";
let activeDirectory = "hospital";
let registering = false;
let currentUser = JSON.parse(localStorage.getItem("cancerCareUser") || "null");
if (!currentUser?.token) {
  currentUser = null;
  localStorage.removeItem("cancerCareUser");
}

const escapeHtml = (value = "") => String(value).replace(/[&<>'"]/g, (char) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", "'": "&#039;", '"': "&quot;" }[char]));

async function request(endpoint, options = {}) {
  const headers = { "Content-Type": "application/json", ...(options.headers || {}) };
  if (currentUser?.token) headers.Authorization = `Bearer ${currentUser.token}`;
  const response = await fetch(`${api}${endpoint}`, { ...options, headers });
  const body = await response.json().catch(() => ({}));
  if (!response.ok) throw new Error(body.error || "Something went wrong. Please try again.");
  return body;
}

function showToast(message) { const toast = $("#toast"); toast.textContent = message; toast.classList.add("show"); setTimeout(() => toast.classList.remove("show"), 3500); }

async function loadOverview() {
  try { const data = await request("/overview"); $("#stats").innerHTML = [[data.hospitals, "Care hospitals"], [data.doctors, "Specialist doctors"], [data.cancer_types, "Cancer guides"], [data.stories, "Community stories"]].map(([count, label]) => `<div><b>${count}+</b><span>${label}</span></div>`).join(""); } catch { showToast("Database summary is unavailable. Check that PostgreSQL is running."); }
}

function hospitalCards(items) {
  return items.length ? items.slice(0, 4).map((item) => `<button class="result" data-hospital="${item.hospital_id}"><i>+</i><span><b>${escapeHtml(item.hospital_name)}</b><small>${escapeHtml(item.area)}, ${escapeHtml(item.district)} | ${escapeHtml(item.hospital_type)}</small></span><strong>&rarr;</strong></button>`).join("") : "<p>No hospitals match your search. Try another area.</p>";
}

function doctorCards(items) {
  return items.length ? items.slice(0, 4).map((item) => `<article class="result doctor-result"><i>${escapeHtml(item.doctor_name.charAt(0))}</i><span><b>${escapeHtml(item.doctor_name)}</b><small>${escapeHtml(item.specialties)} | ${escapeHtml(item.area)}</small></span><strong>${item.experience_years || ""}${item.experience_years ? " yrs" : ""}</strong></article>`).join("") : "<p>No doctors match your search. Try another name or area.</p>";
}

async function loadDirectory(query = "") {
  const results = $("#directoryResults"); results.innerHTML = "<p>Finding care options...</p>";
  try { const items = await request(`/${activeDirectory === "hospital" ? "hospitals" : "doctors"}?search=${encodeURIComponent(query.trim())}`); results.innerHTML = activeDirectory === "hospital" ? hospitalCards(items) : doctorCards(items); }
  catch (error) { results.innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
}

async function loadGuides() {
  try { const guides = await request("/cancers"); const symbols = ["O", "+", "*", "#"]; $("#guideGrid").innerHTML = guides.slice(0, 6).map((guide, index) => `<article class="guide"><i class="g${index % 4}">${symbols[index % 4]}</i><div><small>UNDERSTANDING CANCER</small><h3>${escapeHtml(guide.cancer_name)}</h3><p>${escapeHtml(guide.causes || "Learn about this cancer type and prepare for care.")}</p><a href="#care">Find relevant care &rarr;</a></div></article>`).join(""); }
  catch (error) { $("#guideGrid").innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
}

async function loadLearnArticles() {
  const target = $("#learnArticleGrid");
  if (!target) return;
  try {
    const articles = await request("/learn-articles");
    target.innerHTML = articles.length ? articles.map((article) => `<article class="learn-article">${article.has_photo ? `<img src="/api/learn-articles/${article.article_id}/photo" alt="${escapeHtml(article.title)}" loading="lazy" />` : ""}<div class="learn-article-copy"><small>${escapeHtml(article.category)} · By Dr. ${escapeHtml(article.doctor_name)}</small><h3>${escapeHtml(article.title)}</h3><p class="learn-article-body">${escapeHtml(article.body)}</p>${article.sources ? `<p class="learn-sources"><b>Sources and further reading</b><br>${escapeHtml(article.sources)}</p>` : ""}</div></article>`).join("") : "<p>No doctor-authored articles have been published yet.</p>";
  } catch (error) { target.innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
}

async function loadLearnWorkspace(user) {
  if (user.role === "Doctor") {
    try {
      const submissions = await request("/learn-submissions/mine"), target = $("#myLearnSubmissions");
      if (target) target.innerHTML = submissions.length ? submissions.map((item) => `<li><b>${escapeHtml(item.title)}</b> <span class="submission-status ${escapeHtml(item.status)}">${escapeHtml(item.status)}</span></li>`).join("") : "<li>You have not submitted a Learn article yet.</li>";
    } catch (error) { const target = $("#myLearnSubmissions"); if (target) target.innerHTML = `<li>${escapeHtml(error.message)}</li>`; }
    try {
      const articles = await request("/learn-articles/mine"), target = $("#myLearnArticles");
      if (target) target.innerHTML = ownedLearnCards(articles);
    } catch (error) { const target = $("#myLearnArticles"); if (target) target.innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
  }
  if (user.role === "Admin") {
    await loadPendingLearnArticles();
    await loadPendingContentUpdates();
    await loadAdminPublishedContent();
  }
}

async function loadPendingLearnArticles() {
  const target = $("#pendingLearnArticles");
  if (!target) return;
  try {
    const submissions = await request("/admin/learn-submissions");
    target.innerHTML = submissions.length ? submissions.map((item) => `<article class="learn-review-card">${item.photo_base64 ? `<img src="data:${escapeHtml(item.photo_mime)};base64,${escapeHtml(item.photo_base64)}" alt="Article image preview" />` : ""}<p class="eyebrow">${escapeHtml(item.category)} · Dr. ${escapeHtml(item.doctor_name)} · ${escapeHtml(new Date(item.submitted_at).toLocaleDateString())}</p><h3>${escapeHtml(item.title)}</h3><p class="learn-article-body">${escapeHtml(item.body)}</p>${item.sources ? `<p class="learn-sources"><b>Sources</b><br>${escapeHtml(item.sources)}</p>` : ""}<div class="blog-review-actions"><button class="button learn-moderation" data-action="approve" data-learn-submission="${item.submission_id}">Approve and publish</button><button class="button secondary learn-moderation" data-action="reject" data-learn-submission="${item.submission_id}">Reject</button></div></article>`).join("") : "<p>No Learn articles are waiting for review.</p>";
  } catch (error) { target.innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
}

async function loadPendingContentUpdates() {
  const target = $("#pendingContentUpdates");
  if (!target) return;
  try {
    const updates = await request("/admin/content-updates");
    target.innerHTML = updates.length ? updates.map((item) => `<article class="learn-review-card">${item.photo_base64 ? `<img src="data:${escapeHtml(item.photo_mime)};base64,${escapeHtml(item.photo_base64)}" alt="Replacement image preview" />` : ""}<p class="eyebrow">${item.content_type === "patient_story" ? "PATIENT STORY" : "LEARN ARTICLE"} #${escapeHtml(item.content_id)} · Update #${escapeHtml(item.update_id)}</p><p>Requested by ${escapeHtml(item.author_name)} · ${escapeHtml(new Date(item.submitted_at).toLocaleDateString())}</p><h3>${escapeHtml(item.title)}</h3>${item.category ? `<p>${escapeHtml(item.category)}</p>` : ""}<p class="learn-article-body">${escapeHtml(item.body)}</p>${item.sources ? `<p class="learn-sources"><b>Sources</b><br>${escapeHtml(item.sources)}</p>` : ""}<div class="blog-review-actions"><button class="button content-update-review" data-action="approve" data-update-id="${item.update_id}">Approve update</button><button class="button secondary content-update-review" data-action="reject" data-update-id="${item.update_id}">Reject update</button></div></article>`).join("") : "<p>No author update requests are waiting for review.</p>";
  } catch (error) { target.innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
}

async function loadAdminPublishedContent() {
  try {
    const [stories, articles] = await Promise.all([request("/blogs"), request("/learn-articles")]);
    const storyTarget = $("#adminPublishedStories"), articleTarget = $("#adminPublishedLearnArticles");
    if (storyTarget) storyTarget.innerHTML = stories.length ? stories.map((item) => `<article class="admin-content-row"><span><b>Story #${escapeHtml(item.blog_id)}</b> · ${escapeHtml(item.title)}</span><button class="button danger-button admin-content-delete" data-content-type="story" data-content-id="${item.blog_id}">Delete</button></article>`).join("") : "<p>No published patient stories.</p>";
    if (articleTarget) articleTarget.innerHTML = articles.length ? articles.map((item) => `<article class="admin-content-row"><span><b>Learn article #${escapeHtml(item.article_id)}</b> · ${escapeHtml(item.title)}</span><button class="button danger-button admin-content-delete" data-content-type="learn" data-content-id="${item.article_id}">Delete</button></article>`).join("") : "<p>No published Learn articles.</p>";
  } catch (error) {
    const storyTarget = $("#adminPublishedStories"), articleTarget = $("#adminPublishedLearnArticles");
    if (storyTarget) storyTarget.innerHTML = `<p>${escapeHtml(error.message)}</p>`;
    if (articleTarget) articleTarget.innerHTML = `<p>${escapeHtml(error.message)}</p>`;
  }
}

async function loadStories() {
  try { const stories = await request("/blogs"); $("#storyGrid").innerHTML = stories.length ? stories.map((story, index) => `<article class="story"><div class="story-head s${index % 3}">${["&ldquo;", "+", "&hearts;"][index % 3]}</div><div><small>COMMUNITY STORY</small><h3>${escapeHtml(story.title)}</h3><p>${escapeHtml((story.feel || "A reflection from the CancerCare community.").slice(0, 155))}</p><button class="blog-read" data-read-blog="${story.blog_id}">Read story &rarr;</button></div></article>`).join("") : "<p>No stories have been published yet.</p>"; }
  catch (error) { $("#storyGrid").innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
}

async function openBlog(blogId) {
  const dialog = $("#detailDialog"), content = $("#detailContent");
  dialog.showModal(); content.innerHTML = "<p>Loading story...</p>";
  try {
    const blogs = await request("/blogs");
    const story = blogs.find((item) => String(item.blog_id) === String(blogId));
    if (!story) throw new Error("This story is no longer available.");
    content.innerHTML = `<p class="eyebrow">COMMUNITY STORY</p><h2>${escapeHtml(story.title)}</h2><p class="muted">${escapeHtml(new Date(story.post_date).toLocaleDateString())}</p><p class="blog-full-text">${escapeHtml(story.feel || "")}</p>`;
  } catch (error) { content.innerHTML = `<h2>Story unavailable</h2><p>${escapeHtml(error.message)}</p>`; }
}

function blogCards(stories) {
  return stories.length ? stories.map((story) => `<article class="blog-list-card"><p class="eyebrow">Story #${escapeHtml(story.blog_id)} · ${escapeHtml(new Date(story.post_date).toLocaleDateString())}</p><h3>${escapeHtml(story.title)}</h3><p>${escapeHtml((story.feel || "").slice(0, 220))}${story.feel?.length > 220 ? "..." : ""}</p><button class="inline blog-read" data-read-blog="${story.blog_id}">Read full story &rarr;</button></article>`).join("") : "<p>No published stories yet.</p>";
}

function ownedBlogCards(stories) {
  return stories.length ? stories.map((story) => `<article class="blog-list-card"><p class="eyebrow">Your story #${escapeHtml(story.blog_id)}${story.latest_update_status ? ` · Last edit ${escapeHtml(story.latest_update_status)}` : ""}</p><h3>${escapeHtml(story.title)}</h3><p>${escapeHtml((story.feel || "").slice(0, 220))}${story.feel?.length > 220 ? "..." : ""}</p><details class="content-edit-details"><summary>Request an edit</summary><form class="content-update-form" data-content-update="patient_story" data-content-id="${story.blog_id}"><label>Updated title<input name="title" maxlength="200" value="${escapeHtml(story.title)}" required /></label><label>Updated story<textarea name="body" rows="5" maxlength="10000" required>${escapeHtml(story.feel || "")}</textarea></label><button class="button" type="submit">Send update for approval</button><p class="content-update-message" role="status"></p></form></details></article>`).join("") : "<p>You do not have any published stories yet.</p>";
}

function ownedLearnCards(articles) {
  return articles.length ? articles.map((article) => `<article class="blog-list-card"><p class="eyebrow">Learn article #${escapeHtml(article.article_id)}${article.latest_update_status ? ` · Last edit ${escapeHtml(article.latest_update_status)}` : ""}</p><h3>${escapeHtml(article.title)}</h3><p>${escapeHtml(article.category)}</p><details class="content-edit-details"><summary>Request an edit</summary><form class="content-update-form" data-content-update="learn_article" data-content-id="${article.article_id}"><label>Updated title<input name="title" maxlength="200" value="${escapeHtml(article.title)}" required /></label><label>Topic<input name="category" maxlength="80" value="${escapeHtml(article.category)}" required /></label><label>Updated article<textarea name="body" rows="7" maxlength="50000" required>${escapeHtml(article.body)}</textarea></label><label>Sources<textarea name="sources" rows="3" maxlength="5000">${escapeHtml(article.sources || "")}</textarea></label><label>Replace photo (optional)<input name="photo" type="file" accept="image/jpeg,image/png,image/webp" /></label><button class="button" type="submit">Send update for approval</button><p class="content-update-message" role="status"></p></form></details></article>`).join("") : "<p>You do not have any published Learn articles yet.</p>";
}

async function loadBlogWorkspace(user) {
  try {
    const published = await request("/blogs");
    const target = $("#patientBlogList");
    if (target) target.innerHTML = blogCards(published);
  } catch (error) { const target = $("#patientBlogList"); if (target) target.innerHTML = `<p>${escapeHtml(error.message)}</p>`; }

  if (user.role === "Patient") {
    try {
      const submissions = await request("/blog-submissions/mine"), target = $("#myBlogSubmissions");
      if (target) target.innerHTML = submissions.length ? submissions.map((item) => `<li><b>${escapeHtml(item.title)}</b><span class="submission-status ${escapeHtml(item.status)}">${escapeHtml(item.status)}</span></li>`).join("") : "<li>You have not submitted a story yet.</li>";
    } catch (error) { const target = $("#myBlogSubmissions"); if (target) target.innerHTML = `<li>${escapeHtml(error.message)}</li>`; }
    try {
      const stories = await request("/blogs/mine"), target = $("#myPublishedStories");
      if (target) target.innerHTML = ownedBlogCards(stories);
    } catch (error) { const target = $("#myPublishedStories"); if (target) target.innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
  }
  if (user.role === "Admin") await loadPendingBlogs();
}

async function loadPendingBlogs() {
  const target = $("#pendingBlogList");
  if (!target) return;
  try {
    const items = await request("/admin/blog-submissions");
    target.innerHTML = items.length ? items.map((item) => `<article class="blog-list-card"><p class="eyebrow">From ${escapeHtml(item.patient_name)} · ${escapeHtml(new Date(item.submitted_at).toLocaleDateString())}</p><h3>${escapeHtml(item.title)}</h3><p class="blog-full-text">${escapeHtml(item.body)}</p><div class="blog-review-actions"><button class="button blog-review" data-action="approve" data-submission="${item.submission_id}">Approve and publish</button><button class="button secondary blog-review" data-action="reject" data-submission="${item.submission_id}">Reject</button></div></article>`).join("") : "<p>No stories are waiting for review.</p>";
  } catch (error) { target.innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
}

async function openHospital(id) {
  const dialog = $("#detailDialog"), content = $("#detailContent"); dialog.showModal(); content.innerHTML = "<p>Loading hospital details...</p>";
  try { const hospital = await request(`/hospitals/${id}`); content.innerHTML = `<p class="eyebrow">HOSPITAL PROFILE</p><h2>${escapeHtml(hospital.hospital_name)}</h2><p class="muted">${escapeHtml(hospital.hospital_type)} hospital | ${escapeHtml(hospital.area)}, ${escapeHtml(hospital.district)}</p><div class="details"><div><small>ADDRESS</small><p>${escapeHtml(hospital.address)}</p></div><div><small>CONTACT</small><p>${escapeHtml(hospital.phone)}<br>${escapeHtml(hospital.email || "Contact hospital directly")}</p></div><div><small>CAPACITY</small><p>${escapeHtml(hospital.bed_capacity)} beds</p></div><div><small>ESTABLISHED</small><p>${escapeHtml(hospital.established_year)}</p></div></div>${hospital.website ? `<a class="button" target="_blank" rel="noopener" href="${escapeHtml(hospital.website)}">Visit hospital website &nearr;</a>` : ""}`; }
  catch (error) { content.innerHTML = `<h2>Hospital details unavailable</h2><p>${escapeHtml(error.message)}</p>`; }
}

function openAuth(role) {
  registering = false; $("#loginDialog").showModal(); $("#rolePicker").hidden = true; $("#authForm").hidden = false;
  $("#authRole").value = role; $("#authTitle").textContent = `${role} sign in`; $("#authSubtitle").textContent = "Enter your registered mobile number and password.";
  $("#registrationFields").hidden = true; $("#registerToggle").hidden = role !== "Patient"; $("#authSubmit").innerHTML = "Sign in <b>&rarr;</b>"; $("#authError").textContent = "";
}

function resetAuth() { $("#rolePicker").hidden = false; $("#authForm").hidden = true; $("#authError").textContent = ""; }

function openPublicSection(section) {
  $("#home").hidden = false;
  $("#dashboardView").hidden = true;
  $("#about").hidden = false;
  loadOverview();
  loadDirectory();
  loadGuides();
  loadLearnArticles();
  loadStories();
  requestAnimationFrame(() => document.getElementById(section)?.scrollIntoView({ behavior: "smooth" }));
}

function dashboardFor(user) {
  const views = {
    Patient: { eyebrow: "PATIENT SPACE", title: `Welcome back, ${user.name}.`, intro: "Your care information and learning resources, together in one place.", cards: [["Find care", "Browse hospitals and specialists near you.", "#care"], ["Learn", "Read cancer guides and doctor-authored articles.", "#learn"], ["Community stories", "Read patient stories or share your own.", "#patient-blogs"]] },
    Doctor: { eyebrow: "CLINICAL WORKSPACE", title: `Good to see you, Dr. ${user.name}.`, intro: "A workspace for your schedule, patient visits, and educational contributions.", cards: [["Today's schedule", "Review appointments and visits assigned by management.", "#doctor-schedule"], ["Care directory", "Find hospitals and connect patients with relevant services.", "#care"], ["Write a Learn article", "Share educational information for admin review.", "#doctor-learn-articles"]] },
    Admin: { eyebrow: "ADMIN WORKSPACE", title: `Welcome, ${user.name}.`, intro: "Review CancerCare activity and manage information shared with patients.", cards: [["Network overview", "View hospitals, doctors, cancer guides, and stories.", "#admin-overview"], ["Patient stories", "Approve patient community stories.", "#admin-blog-review"], ["Learn articles", "Review doctor-authored educational content.", "#admin-learn-review"]] }
  };
  const view = views[user.role] || views.Patient;
  const roleOverview = user.role === "Patient" ? `<section class="workspace-panel"><p class="eyebrow">YOUR CARE</p><h2>Care at a glance</h2><div class="workspace-stats"><article><span>Appointments</span><b>Not set up yet</b><p>Your appointments will appear here when booking is available.</p></article><article><span>Prescriptions</span><b>Not set up yet</b><p>Prescription details will be added to your care page later.</p></article><article><span>Patient ID</span><b>#${escapeHtml(user.id)}</b><p>Your CancerCare account identifier.</p></article></div></section>` : user.role === "Doctor" ? `<section id="doctor-schedule" class="workspace-panel"><p class="eyebrow">TODAY · ${escapeHtml(new Date().toLocaleDateString())}</p><h2>Today's schedule</h2><div class="workspace-columns"><article class="workspace-empty"><b>Visits and appointments</b><p>No schedule entries are available yet. Admin-assigned visits will appear here when scheduling is added.</p></article><article class="workspace-empty"><b>Operations</b><p>Planned operations and related patient visits will appear here when those records are available.</p></article></div><div class="workspace-note"><b>Assigned patients</b><p>Patient lists and care schedules are not connected yet.</p></div></section>` : `<section id="admin-overview" class="workspace-panel"><p class="eyebrow">CANCERCARE NETWORK</p><h2>Management overview</h2><div id="adminDashboardStats" class="workspace-stats"><article><span>Hospitals</span><b>Loading</b></article><article><span>Doctors</span><b>Loading</b></article><article><span>Cancer guides</span><b>Loading</b></article><article><span>Published stories</span><b>Loading</b></article></div><div class="workspace-note"><b>Content review</b><p>Use the review sections below to approve patient stories and doctor-authored Learn articles.</p></div></section>`;
  $("#home").hidden = true;
  $("#dashboardView").hidden = false;
  $("#about").hidden = true;
  $("#dashboardView").innerHTML = `<section class="dashboard container"><div class="dashboard-top"><div><p class="eyebrow">— &nbsp; ${view.eyebrow}</p><h1>${escapeHtml(view.title)}</h1><p class="intro">${escapeHtml(view.intro)}</p></div><button id="logoutButton" class="button">Sign out <b>&rarr;</b></button></div><div class="dashboard-grid">${view.cards.map(([title, text, href]) => `<a class="dashboard-card" href="${href}"><span>${escapeHtml(user.role)}</span><h2>${title}</h2><p>${text}</p><strong>Open workspace &rarr;</strong></a>`).join("")}</div>${roleOverview}${user.role === "Patient" ? `<section id="patient-blogs" class="blog-workspace"><p class="eyebrow">COMMUNITY BLOGS</p><h2>Stories from patients</h2><div id="patientBlogList" class="blog-list"><p>Loading stories...</p></div><div class="blog-compose"><h2>Share your story</h2><p>Your story will be reviewed by an admin before it is published.</p><form id="blogSubmissionForm"><label>Story title<input name="title" maxlength="200" required /></label><label>Your story<textarea name="body" rows="6" maxlength="10000" required></textarea></label><button class="button" type="submit">Send for review <b>&rarr;</b></button><p id="blogSubmissionMessage" role="status"></p></form><h3>Your submissions</h3><ul id="myBlogSubmissions" class="submission-list"><li>Loading...</li></ul></div></section>` : user.role === "Doctor" ? `<section id="doctor-learn-articles" class="blog-workspace"><p class="eyebrow">DOCTOR EDUCATION</p><h2>Submit a Learn article</h2><p>Articles are reviewed by an admin before they appear in Learn.</p><div class="blog-compose"><form id="learnSubmissionForm"><label>Article title<input name="title" maxlength="200" required /></label><label>Topic<select name="category"><option>General education</option><option>Cancer prevention</option><option>Diagnosis and screening</option><option>Treatment and care</option><option>Living with cancer</option><option>Research update</option></select></label><label>Article<textarea name="body" rows="9" maxlength="50000" required></textarea></label><label>Sources and further reading<textarea name="sources" rows="4" maxlength="5000" placeholder="List references, links, or research sources"></textarea></label><label>Article photo (JPG, PNG, or WebP; max 2 MB)<input name="photo" type="file" accept="image/jpeg,image/png,image/webp" /></label><button class="button" type="submit">Send for admin review <b>&rarr;</b></button><p id="learnSubmissionMessage" role="status"></p></form></div><h3>Your Learn submissions</h3><ul id="myLearnSubmissions" class="submission-list"><li>Loading...</li></ul></section>` : user.role === "Admin" ? `<section id="admin-blog-review" class="blog-workspace"><p class="eyebrow">CONTENT REVIEW</p><h2>Patient blog submissions</h2><p>Approve a story to publish it on the community blog page.</p><div id="pendingBlogList" class="blog-list"><p>Loading submissions...</p></div></section><section id="admin-learn-review" class="blog-workspace"><p class="eyebrow">LEARN REVIEW</p><h2>Doctor article submissions</h2><p>Approve an article to publish it in the Learn section.</p><div id="pendingLearnArticles" class="learn-review-list"><p>Loading submissions...</p></div></section>` : ""}</section>`;
  if (user.role === "Patient") {
    $("#patientBlogList").insertAdjacentHTML("afterend", `<h3>Your published stories</h3><div id="myPublishedStories" class="blog-list"><p>Loading your stories...</p></div>`);
  }
  if (user.role === "Doctor") {
    $("#myLearnSubmissions").insertAdjacentHTML("beforebegin", `<h3>Your published Learn articles</h3><div id="myLearnArticles" class="blog-list"><p>Loading your articles...</p></div>`);
  }
  if (user.role === "Admin") {
    $("#admin-learn-review").insertAdjacentHTML("afterend", `<section id="admin-update-review" class="blog-workspace"><p class="eyebrow">AUTHOR UPDATE REQUESTS</p><h2>Published content updates</h2><p>Authors’ changes stay unpublished until you approve them.</p><div id="pendingContentUpdates" class="learn-review-list"><p>Loading update requests...</p></div></section><section id="admin-content-management" class="blog-workspace"><p class="eyebrow">PUBLISHED CONTENT</p><h2>Manage published stories and Learn articles</h2><h3>Patient stories</h3><div id="adminPublishedStories" class="admin-content-list"><p>Loading stories...</p></div><h3>Learn articles</h3><div id="adminPublishedLearnArticles" class="admin-content-list"><p>Loading articles...</p></div></section>`);
  }
  if (user.role === "Patient" || user.role === "Admin") loadBlogWorkspace(user);
  if (user.role === "Doctor" || user.role === "Admin") loadLearnWorkspace(user);
  if (user.role === "Admin") loadAdminDashboardStats();
  $("#openLogin").textContent = "Sign out";
  $("#logoutButton").addEventListener("click", logout);
}

function logout() {
  currentUser = null;
  localStorage.removeItem("cancerCareUser");
  $("#dashboardView").hidden = true;
  $("#home").hidden = false;
  $("#about").hidden = false;
  $("#openLogin").textContent = "◌  Sign in";
  window.scrollTo({ top: 0, behavior: "smooth" });
}

$("#openLogin").addEventListener("click", () => { if (currentUser) logout(); else { $("#loginDialog").showModal(); resetAuth(); } });
document.addEventListener("click", (event) => {
  const editReview = event.target.closest("[data-update-id]");
  if (editReview) { reviewContentUpdate(editReview); return; }
  const deleteContent = event.target.closest(".admin-content-delete");
  if (deleteContent) { deletePublishedContent(deleteContent); return; }
  const readButton = event.target.closest("[data-read-blog]");
  if (readButton) { openBlog(readButton.dataset.readBlog); return; }
  const learnModerationButton = event.target.closest("[data-learn-submission]");
  if (learnModerationButton) { reviewLearnSubmission(learnModerationButton); return; }
  const reviewButton = event.target.closest("[data-submission]");
  if (reviewButton) { reviewSubmission(reviewButton); return; }
  const link = event.target.closest("a[href^='#']");
  const section = link?.getAttribute("href")?.slice(1);
  if (currentUser && $("#home").hidden && ["care", "learn", "stories", "about"].includes(section)) {
    event.preventDefault();
    openPublicSection(section);
  }
});
document.addEventListener("submit", async (event) => {
  if (event.target.matches(".content-update-form")) {
    event.preventDefault();
    const form = event.target, message = form.querySelector(".content-update-message"), submit = form.querySelector("button[type='submit']");
    const file = form.elements.photo?.files?.[0];
    if (file && (!["image/jpeg", "image/png", "image/webp"].includes(file.type) || file.size > 2 * 1024 * 1024)) {
      message.textContent = "Choose a JPG, PNG, or WebP image smaller than 2 MB.";
      return;
    }
    message.textContent = ""; submit.disabled = true;
    try {
      const imageData = file ? await new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => resolve(reader.result);
        reader.onerror = () => reject(new Error("The image could not be read."));
        reader.readAsDataURL(file);
      }) : null;
      const payload = { title: form.elements.title.value, body: form.elements.body.value, category: form.elements.category?.value, sources: form.elements.sources?.value, imageData };
      const path = form.dataset.contentUpdate === "patient_story"
        ? `/blogs/${form.dataset.contentId}/update-requests`
        : `/learn-articles/${form.dataset.contentId}/update-requests`;
      const data = await request(path, { method: "POST", body: JSON.stringify(payload) });
      message.textContent = data.message;
      showToast(data.message);
      if (currentUser.role === "Patient") await loadBlogWorkspace(currentUser);
      else await loadLearnWorkspace(currentUser);
    } catch (error) { message.textContent = error.message; }
    finally { submit.disabled = false; }
    return;
  }
  if (event.target.id === "learnSubmissionForm") {
    event.preventDefault();
    const form = event.target, message = $("#learnSubmissionMessage"), submit = form.querySelector("button[type='submit']");
    const file = form.elements.photo.files[0];
    if (file && (!["image/jpeg", "image/png", "image/webp"].includes(file.type) || file.size > 2 * 1024 * 1024)) {
      message.textContent = "Choose a JPG, PNG, or WebP image smaller than 2 MB.";
      return;
    }
    message.textContent = ""; submit.disabled = true;
    try {
      const imageData = file ? await new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => resolve(reader.result);
        reader.onerror = () => reject(new Error("The image could not be read."));
        reader.readAsDataURL(file);
      }) : null;
      const data = await request("/learn-submissions", { method: "POST", body: JSON.stringify({
        title: form.elements.title.value,
        category: form.elements.category.value,
        body: form.elements.body.value,
        sources: form.elements.sources.value,
        imageData
      }) });
      message.textContent = data.message; form.reset(); await loadLearnWorkspace(currentUser);
    } catch (error) { message.textContent = error.message; }
    finally { submit.disabled = false; }
    return;
  }
  if (event.target.id !== "blogSubmissionForm") return;
  event.preventDefault();
  const form = event.target, message = $("#blogSubmissionMessage"), submit = form.querySelector("button[type='submit']");
  message.textContent = ""; submit.disabled = true;
  try {
    const data = await request("/blog-submissions", { method: "POST", body: JSON.stringify({ title: form.elements.title.value, body: form.elements.body.value }) });
    message.textContent = data.message; form.reset(); await loadBlogWorkspace(currentUser);
  } catch (error) { message.textContent = error.message; }
  finally { submit.disabled = false; }
});

async function reviewContentUpdate(button) {
  button.disabled = true;
  try {
    const result = await request(`/admin/content-updates/${button.dataset.updateId}/${button.dataset.action}`, { method: "POST" });
    showToast(result.message);
    await Promise.all([loadPendingContentUpdates(), loadAdminPublishedContent()]);
  } catch (error) { showToast(error.message); button.disabled = false; }
}

async function deletePublishedContent(button) {
  const type = button.dataset.contentType;
  const id = button.dataset.contentId;
  const label = type === "story" ? `patient story #${id}` : `Learn article #${id}`;
  if (!window.confirm(`Delete ${label}? This removes it from the website.`)) return;
  button.disabled = true;
  try {
    const endpoint = type === "story" ? `/admin/blogs/${id}` : `/admin/learn-articles/${id}`;
    const result = await request(endpoint, { method: "DELETE" });
    showToast(result.message);
    await Promise.all([loadAdminPublishedContent(), loadPendingContentUpdates()]);
  } catch (error) { showToast(error.message); button.disabled = false; }
}

async function reviewLearnSubmission(button) {
  button.disabled = true;
  try {
    const action = button.dataset.action;
    const result = await request(`/admin/learn-submissions/${button.dataset.learnSubmission}/${action}`, { method: "POST" });
    showToast(result.message); await Promise.all([loadPendingLearnArticles(), loadAdminPublishedContent()]);
  } catch (error) { showToast(error.message); button.disabled = false; }
}

async function loadAdminDashboardStats() {
  const target = $("#adminDashboardStats");
  if (!target) return;
  try {
    const data = await request("/overview");
    target.innerHTML = [[data.hospitals, "Hospitals"], [data.doctors, "Doctors"], [data.cancer_types, "Cancer guides"], [data.stories, "Published stories"]]
      .map(([count, label]) => `<article><span>${escapeHtml(label)}</span><b>${escapeHtml(count)}</b></article>`).join("");
  } catch (error) {
    target.innerHTML = `<p>${escapeHtml(error.message)}</p>`;
  }
}

async function reviewSubmission(button) {
  button.disabled = true;
  try {
    const action = button.dataset.action;
    const result = await request(`/admin/blog-submissions/${button.dataset.submission}/${action}`, { method: "POST" });
    showToast(result.message); await Promise.all([loadPendingBlogs(), loadAdminPublishedContent()]);
  } catch (error) { showToast(error.message); button.disabled = false; }
}
document.querySelectorAll(".close").forEach((button) => button.addEventListener("click", () => button.closest("dialog").close()));
document.querySelectorAll("[data-role]").forEach((button) => button.addEventListener("click", () => openAuth(button.dataset.role)));
$("#backToRoles").addEventListener("click", resetAuth);
$("#registerToggle").addEventListener("click", () => { registering = !registering; $("#registrationFields").hidden = !registering; $("#authTitle").textContent = registering ? "Create a patient account" : "Patient sign in"; $("#authSubtitle").textContent = registering ? "Your details create a secure patient profile." : "Enter your registered mobile number and password."; $("#authSubmit").innerHTML = registering ? "Create account <b>&rarr;</b>" : "Sign in <b>&rarr;</b>"; $("#registerToggle").textContent = registering ? "I already have an account" : "Create a patient account"; });
$("#authForm").addEventListener("submit", async (event) => { event.preventDefault(); const error = $("#authError"), submit = $("#authSubmit"); error.textContent = ""; submit.disabled = true; submit.textContent = registering ? "Creating account..." : "Signing in..."; try { const payload = registering ? { firstName: $("#firstName").value, lastName: $("#lastName").value, contact: $("#authContact").value, password: $("#authPassword").value, address: $("#address").value, district: $("#district").value, area: $("#area").value, gender: $("#gender").value } : { contact: $("#authContact").value, password: $("#authPassword").value, role: $("#authRole").value }; const data = await request(registering ? "/auth/register" : "/auth/login", { method: "POST", body: JSON.stringify(payload) }); currentUser = { ...data.user, token: data.token }; localStorage.setItem("cancerCareUser", JSON.stringify(currentUser)); $("#loginDialog").close(); dashboardFor(currentUser); showToast(`Welcome, ${data.user.name}. You are signed in as ${data.user.role}.`); } catch (err) { error.textContent = err.message; } finally { submit.disabled = false; submit.innerHTML = registering ? "Create account <b>&rarr;</b>" : "Sign in <b>&rarr;</b>"; } });
document.querySelectorAll(".tabs button").forEach((button) => button.addEventListener("click", () => { activeDirectory = button.dataset.search; document.querySelectorAll(".tabs button").forEach((tab) => tab.classList.toggle("active", tab === button)); $("#directorySearch").placeholder = activeDirectory === "hospital" ? "Search by hospital name or area" : "Search doctor name or area"; loadDirectory($("#directorySearch").value); }));
$("#searchButton").addEventListener("click", () => loadDirectory($("#directorySearch").value));
$("#directorySearch").addEventListener("keydown", (event) => { if (event.key === "Enter") loadDirectory(event.target.value); });
$("#directoryResults").addEventListener("click", (event) => { const card = event.target.closest("[data-hospital]"); if (card) openHospital(card.dataset.hospital); });
$(".menu").addEventListener("click", () => $(".links").classList.toggle("show"));
if (currentUser) dashboardFor(currentUser);
else { loadOverview(); loadDirectory(); loadGuides(); loadLearnArticles(); loadStories(); }
