FROM node:22

# Corepack allows us to use pnpm right out of the box without having to install it ourselves
RUN corepack enable

# Create and change to the app directory
WORKDIR /code

# Copy package.json and package-lock.json
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN --mount=type=cache,id=pnpm,target=/root/.local/share/pnpm/store pnpm fetch --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Command to run tests
CMD ["npm", "run", "test"]