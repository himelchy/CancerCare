const $ = (selector) => document.querySelector(selector);
const api = "/api";
let activeDirectory = "hospital";
let registering = false;

const escapeHtml = (value = "") => String(value).replace(/[&<>'"]/g, (char) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", "'": "&#039;", '"': "&quot;" }[char]));

async function request(endpoint, options = {}) {
  const response = await fetch(`${api}${endpoint}`, { headers: { "Content-Type": "application/json" }, ...options });
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

async function loadStories() {
  try { const stories = await request("/blogs"); $("#storyGrid").innerHTML = stories.map((story, index) => `<article class="story"><div class="story-head s${index}">${["&ldquo;", "+", "&hearts;"][index]}</div><div><small>COMMUNITY STORY</small><h3>${escapeHtml(story.title)}</h3><p>${escapeHtml((story.feel || "A reflection from the CancerCare community.").slice(0, 155))}</p><a href="#stories">Read story &rarr;</a></div></article>`).join(""); }
  catch (error) { $("#storyGrid").innerHTML = `<p>${escapeHtml(error.message)}</p>`; }
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

$("#openLogin").addEventListener("click", () => { $("#loginDialog").showModal(); resetAuth(); });
document.querySelectorAll(".close").forEach((button) => button.addEventListener("click", () => button.closest("dialog").close()));
document.querySelectorAll("[data-role]").forEach((button) => button.addEventListener("click", () => openAuth(button.dataset.role)));
$("#backToRoles").addEventListener("click", resetAuth);
$("#registerToggle").addEventListener("click", () => { registering = !registering; $("#registrationFields").hidden = !registering; $("#authTitle").textContent = registering ? "Create a patient account" : "Patient sign in"; $("#authSubtitle").textContent = registering ? "Your details create a secure patient profile." : "Enter your registered mobile number and password."; $("#authSubmit").innerHTML = registering ? "Create account <b>&rarr;</b>" : "Sign in <b>&rarr;</b>"; $("#registerToggle").textContent = registering ? "I already have an account" : "Create a patient account"; });
$("#authForm").addEventListener("submit", async (event) => { event.preventDefault(); const error = $("#authError"), submit = $("#authSubmit"); error.textContent = ""; submit.disabled = true; submit.textContent = registering ? "Creating account..." : "Signing in..."; try { const payload = registering ? { firstName: $("#firstName").value, lastName: $("#lastName").value, contact: $("#authContact").value, password: $("#authPassword").value, address: $("#address").value, district: $("#district").value, area: $("#area").value, gender: $("#gender").value } : { contact: $("#authContact").value, password: $("#authPassword").value, role: $("#authRole").value }; const data = await request(registering ? "/auth/register" : "/auth/login", { method: "POST", body: JSON.stringify(payload) }); localStorage.setItem("cancerCareUser", JSON.stringify(data.user)); $("#loginDialog").close(); showToast(`Welcome, ${data.user.name}. You are signed in as ${data.user.role}.`); } catch (err) { error.textContent = err.message; } finally { submit.disabled = false; submit.innerHTML = registering ? "Create account <b>&rarr;</b>" : "Sign in <b>&rarr;</b>"; } });
document.querySelectorAll(".tabs button").forEach((button) => button.addEventListener("click", () => { activeDirectory = button.dataset.search; document.querySelectorAll(".tabs button").forEach((tab) => tab.classList.toggle("active", tab === button)); $("#directorySearch").placeholder = activeDirectory === "hospital" ? "Search by hospital name or area" : "Search doctor name or area"; loadDirectory($("#directorySearch").value); }));
$("#searchButton").addEventListener("click", () => loadDirectory($("#directorySearch").value));
$("#directorySearch").addEventListener("keydown", (event) => { if (event.key === "Enter") loadDirectory(event.target.value); });
$("#directoryResults").addEventListener("click", (event) => { const card = event.target.closest("[data-hospital]"); if (card) openHospital(card.dataset.hospital); });
$(".menu").addEventListener("click", () => $(".links").classList.toggle("show"));
loadOverview(); loadDirectory(); loadGuides(); loadStories();
