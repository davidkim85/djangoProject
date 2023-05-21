# Pull official base Python Docker image
FROM python:3.10.6
# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
# Set work directory
WORKDIR /code
# Install dependencies
RUN pip install --upgrade pip
COPY requirements.txt /code/
RUN pip install -r requirements.txt
RUN chmod +x "./wait-for-it.sh db:5432" \
mkdir "/code"
RUN chmod -R "www-data:www-data /code"
# Copy the Django project
COPY . /code/
ENTRYPOINT ["./wait-for-it.sh db:5432"]
