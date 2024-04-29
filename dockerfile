FROM python:3.10

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/root/.local/bin:${PATH}"

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Install Git (required for installing Whisper)
RUN apt-get update && apt-get install -y git ffmpeg

# Install Whisper
RUN pip install git+https://github.com/openai/whisper.git

# Copy the Flask application code
COPY . .

# Expose the port 5000
EXPOSE 5000

# Set the environment variable for the Flask app
ENV FLASK_APP=text.py

# Start the Gunicorn server
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000"]
