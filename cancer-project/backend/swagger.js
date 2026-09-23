const swaggerJsdoc = require("swagger-jsdoc");

const options = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: "CancerCare API",
            version: "1.0.0",
            description: "Backend API for the CancerCare application"
        },
        servers: [
            {
                url: "http://localhost:5000"
            }
        ]
    },
    apis: ["./server.js"]
};

module.exports = swaggerJsdoc(options);