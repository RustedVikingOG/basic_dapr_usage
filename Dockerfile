# ============================
# UI
# ============================
FROM node:16 AS frontend
WORKDIR /app/frontend
# Install dependencies and build Vue dev server if needed
COPY ui/package*.json ./
RUN npm install
COPY ui/ .
# For development, you might not build; you can run npm run serve directly


# ============================
# SERVICES
# ============================
FROM python:3.12-slim AS backend
WORKDIR /app/backend
# Install Python dependencies
COPY backend/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY backend/ .



# ============================
# FINAL IMAGE
# ============================
# Install Supervisor & other necessities
RUN apt-get update && apt-get install -y curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get install -y supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy Supervisor configuration file
COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# Copy built frontend or the development folder (if using dev server)
# COPY --from=frontend /app/frontend /app/frontend

EXPOSE 5000 9000

CMD ["/usr/bin/supervisord", "-n"]
