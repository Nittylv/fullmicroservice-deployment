# Use the official Node.js image as the base image
FROM node:14

# Set the working directory in the container
RUN mkdir -p /app
WORKDIR /app
# Copy package.json and package-lock.json to the working directory
COPY package*.json /app/

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . /app/

# Expose the port your app runs on
EXPOSE 3000

# Start your Node.js application
CMD ["node", "run", "Start"]
