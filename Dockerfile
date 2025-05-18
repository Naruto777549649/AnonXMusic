FROM nikolaik/python-nodejs:python3.11-nodejs19

# Install ffmpeg and other dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && apt-get install -y openssl ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Confirm Node.js installation
RUN node -v && npm -v

# Copy app files
COPY . /app/
WORKDIR /app/

# Install Python dependencies
RUN pip3 install --no-cache-dir -U -r requirements.txt

# Optional: Show OpenSSL version for debugging
RUN python3 -c "import ssl; print(ssl.OPENSSL_VERSION)"

# Make sure start script is executable
RUN chmod +x start

# Use bash to run your start script
CMD ["bash", "start"]