const hospitalSelect = document.getElementById("hospitalSelect");
const viewButton = document.getElementById("viewButton");
const hospitalDetails = document.getElementById("hospitalDetails");


// Load all hospitals
async function loadHospitals() {
    try {
        const response = await fetch(
            "http://localhost:5000/api/hospitals"
        );

        const hospitals = await response.json();

        hospitals.forEach((hospital) => {

            const option = document.createElement("option");

            option.value = hospital.hospital_id;
            option.textContent = hospital.hospital_name;

            hospitalSelect.appendChild(option);
        });

    } catch (error) {
        console.error("Failed to load hospitals:", error);
    }
}


// Get selected hospital details
async function showHospitalDetails() {

    const hospitalId = hospitalSelect.value;

    if (!hospitalId) {
        hospitalDetails.innerHTML =
            "<p>Please select a hospital first.</p>";

        return;
    }

    try {

        const response = await fetch(
            `http://localhost:5000/api/hospitals/${hospitalId}`
        );

        const hospital = await response.json();

        hospitalDetails.innerHTML = `
            <div class="hospital-card">

                <h2>${hospital.hospital_name}</h2>

                <p>
                    <strong>Registration:</strong>
                    ${hospital.registration_no}
                </p>

                <p>
                    <strong>Address:</strong>
                    ${hospital.address}
                </p>

                <p>
                    <strong>District:</strong>
                    ${hospital.district}
                </p>

                <p>
                    <strong>Area:</strong>
                    ${hospital.area}
                </p>

                <p>
                    <strong>Phone:</strong>
                    ${hospital.phone}
                </p>

                <p>
                    <strong>Email:</strong>
                    ${hospital.email}
                </p>

                <p>
                    <strong>Established:</strong>
                    ${hospital.established_year}
                </p>

                <p>
                    <strong>Bed Capacity:</strong>
                    ${hospital.bed_capacity}
                </p>

                <p>
                    <strong>Type:</strong>
                    ${hospital.hospital_type}
                </p>

                <p>
                    <strong>Website:</strong>
                    ${hospital.website}
                </p>

            </div>
        `;

    } catch (error) {

        console.error(
            "Failed to load hospital details:",
            error
        );

        hospitalDetails.innerHTML =
            "<p>Could not load hospital details.</p>";
    }
}


// Button click
viewButton.addEventListener(
    "click",
    showHospitalDetails
);


// Load hospitals when page opens
loadHospitals();