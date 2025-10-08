FROM python:3-alpine

# Set environment variables
ENV APP_DIR=/var/app
ENV APP_USER=flaskuser

# Create app directory and user
RUN mkdir -p $APP_DIR && \
    adduser -D -h $APP_DIR -s /bin/sh $APP_USER

# Set working directory
WORKDIR $APP_DIR

# Copy application files
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Change ownership to non-root user
RUN chown -R $APP_USER:$APP_USER $APP_DIR
EXPOSE 8080
# Switch to non-root user
USER $APP_USER

# Default command to run Flask app
CMD ["python3", "app.py"]

