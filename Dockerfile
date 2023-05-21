# Pull official base Python Docker image
FROM python:3.10.6
RUN mkdir /code
WORKDIR /code
COPY . /code/
# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
# Set work directory
RUN apk add python3-dev build-base linux-headers pcre-dev
# Install dependencies
RUN pip install --upgrade pip
COPY requirements.txt /code/
RUN pip install -r requirements.txt
RUN chmod +x "./wait-for-it.sh db:5432" && mkdir /var/run/uwsgi && chown -R www-data:www-data /var/run/uwsgi
# Copy the Django project
CMD ["uwsgi","--ini","./uwsgi/uwsgi.ini" ]
ENTRYPOINT ["./wait-for-it.sh db:5432"]
