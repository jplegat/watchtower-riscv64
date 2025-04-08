FROM alpine:latest AS builder

# Install necessary tools for building Go applications
RUN apk add --no-cache git go tzdata

# Set the working directory inside the container
WORKDIR /app

# Clone the Watchtower repository
RUN git clone https://github.com/containrrr/watchtower.git .

# Build the Watchtower application
RUN go build -o watchtower .

# Create a new lightweight image for the final deployment
FROM alpine:latest

# Copy the Watchtower binary from the builder stage
COPY --from=builder /app/watchtower /usr/local/bin/watchtower

# Set the entrypoint for the container
ENTRYPOINT ["/usr/local/bin/watchtower"]

# Optionally, define the command to run when the container starts
# CMD ["--cleanup"]