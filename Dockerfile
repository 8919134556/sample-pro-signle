# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Install dependencies
RUN npm install

# Copy the server.js file and the HTML page into the container
COPY . .

# Expose the necessary port
EXPOSE 3001

# Command to run the Node.js server
CMD [ "node", "server.js" ]
