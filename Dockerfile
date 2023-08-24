# Use the official OpenJDK image as the base image
FROM openjdk:8-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the Java source code into the container
COPY HelloWorld.java .

# Compile the Java code
RUN javac HelloWorld.java

# Run the compiled Java program when the container starts
CMD ["java", "HelloWorld"]
