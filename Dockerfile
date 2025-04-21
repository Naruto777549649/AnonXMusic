FROM nikolaik/python-nodejs:python3.11-nodejs19

# Install ffmpeg and update OpenSSL (if needed)
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && apt-get install -y openssl ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy app files and install dependencies
COPY . /app/
WORKDIR /app/
RUN pip3 install --no-cache-dir -U -r requirements.txt

# Ensure correct SSL libraries (optional)
RUN python3 -c "import ssl; print(ssl.OPENSSL_VERSION)"

# Set the entry point for the container
CMD bash start