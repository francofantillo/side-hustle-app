# side_hustle

I'll help you use the existing Docker setup. Here are the steps to get your environment running:

1. **Build the Docker Image**
```bash
docker-compose build
```

2. **Start an Interactive Shell**
```bash
docker-compose run --rm firebase-tools bash
```

3. **Inside the Container, Login to Firebase**
```bash
firebase login --no-localhost
```

4. **Configure FlutterFire**
```bash
# Only use if setting up platform app (iOS/Android) for the first time
flutterfire configure --project=side-hustle-11c42 
```

5. **Common Flutter Commands Inside Container**
```bash
# Get dependencies
flutter pub get

# Run Flutter doctor
flutter doctor

# Build Android APK
flutter build apk

# Check Firebase CLI version
firebase --version
```

6. **Working with Firebase**
```bash
# List Firebase projects
firebase projects:list

# Initialize Firebase features
firebase init

# Deploy Firebase configurations
firebase deploy
```

7. **Exit the Container**
```bash
exit
```

Remember:
- Your project files are mounted at `/app` in the container
- Configuration changes persist through the mounted volumes
- For iOS builds, you'll still need to use your Mac host
- The container preserves Firebase authentication between sessions

You can now use this environment for Firebase configuration and Flutter development.
