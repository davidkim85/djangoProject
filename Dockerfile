# Pull official base Python Docker image
FROM python:3.10.6
WORKDIR /code
COPY . /code/
# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
# Set work directory
# Install dependencies
RUN pip install --upgrade pip
COPY requirements.txt /code/
RUN pip install -r requirements.txt
RUN chmod +x "wait-for-it.sh"
# Copy the Django project

ENTRYPOINT ["wait-for-it.sh db:5432"]
