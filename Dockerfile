FROM node:18

# Install Firebase CLI
RUN npm install -g firebase-tools

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa

# Download and install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Add Flutter and Dart to PATH
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Initialize Flutter
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --no-analytics
RUN flutter precache
RUN flutter doctor

# Install FlutterFire CLI after Flutter is fully initialized
RUN dart pub global activate flutterfire_cli

WORKDIR /app

# Add pub cache to PATH
ENV PATH="/root/.pub-cache/bin:${PATH}"