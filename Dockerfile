FROM node:22

# Create and change to the app directory
WORKDIR /code

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Command to run tests
CMD ["npm", "run", "test"]