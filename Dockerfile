FROM macjustice/git-lfs


RUN apt-get update -q && \
    apt-get install -qy openjdk-8-jdk-headless unzip && \
    rm -rf /var/lib/apt/lists/*

# Install Android SDK Tools
ENV ANDROID_HOME=/opt/android-sdk
WORKDIR $ANDROID_HOME
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
    unzip sdk-tools-linux-3859397.zip && \
    rm sdk-tools-linux-3859397.zip

# Preemptively accept Android SDK licenses
RUN yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

# Install Android SDK parts - build-tools, extras, platform and platform-tools
RUN $ANDROID_HOME/tools/bin/sdkmanager 'build-tools;25.0.3' 'build-tools;25.0.2' 'platforms;android-25' platform-tools 'extras;android;m2repository' 'extras;google;m2repository'

# Install Gradle 3.3
ENV PATH=$PATH:/opt/gradle/gradle-3.3/bin
WORKDIR /opt/gradle
RUN wget https://services.gradle.org/distributions/gradle-3.3-bin.zip && \
    unzip gradle-3.3-bin.zip && \
    rm gradle-3.3-bin.zip

WORKDIR /data
VOLUME ["/data"]

