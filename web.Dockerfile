# This app runs on ubuntu but relies on Swift and Node to build its application assets and binaries.
# Read more about multistage builds here: https://docs.docker.com/develop/develop-images/multistage-build/

# Build the node assets first
FROM node:7.7.3 as nodebuilder
COPY . .
RUN npm install
RUN npm rebuild node-sass
RUN npm run build

# You can set the Swift version to what you need for your app. Versions can be found here: https://hub.docker.com/_/swift
FROM swift:5.0 as builder

# For local build, add `--build-arg env=docker`
# In your application, you can use `Environment.custom(name: "docker")` to check if you're in this env
ARG env

RUN apt-get -qq update && apt-get install -y \
  libssl-dev zlib1g-dev \
  && rm -r /var/lib/apt/lists/*
WORKDIR /app
COPY . .
RUN mkdir -p /build/lib && cp -R /usr/lib/swift/linux/*.so* /build/lib
RUN swift build -c release && mv `swift build -c release --show-bin-path` /build/bin

# Production image
FROM ubuntu:18.04
ARG env
# DEBIAN_FRONTEND=noninteractive for automatic UTC configuration in tzdata
RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libatomic1 libicu60 libxml2 libcurl4 libz-dev libbsd0 tzdata \
  && rm -r /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /build/bin/Run .
COPY --from=builder /build/lib/* /usr/lib/
# Uncomment the next line if you need to load resources from the `Public` directory
COPY --from=builder /app/Public ./Public
# Uncomment the next line if you are using Leaf
COPY --from=builder /app/Resources ./Resources
# Copy nodebuilder files
COPY --from=nodebuilder /app/Resources ./Resources
ENV ENVIRONMENT=$env

ENTRYPOINT ./Run serve --env $ENVIRONMENT --hostname 0.0.0.0 --port 80
