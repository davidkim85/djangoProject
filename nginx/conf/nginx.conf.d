# upstream for uWSGI
upstream uwsgi_app {
    server unix:/code/uwsgi_app.sock;
}

server {
    listen 80;
    listen [::]:80;
    server_name furmandavid.info;

    location /.well-known/acme-challenge/ {
        allow all;
        root /var/www/html;
    }
    location / {
        return 301 https://$host$request_uri? permanent;
    }
}
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name furmandavid.info;
    server_tokens off;
    ssl_certificate /etc/letsencrypt/live/furmandavid.info/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/furmandavid.info/privkey.pem;
    include /etc/nginx/conf.d/options-sll-nginx.conf;
    error_log    stderr warn;
    access_log   /dev/stdout main;

    location / {
        include      /etc/nginx/uwsgi_params;
        uwsgi_pass   uwsgi_app;
    }

    location /static/ {
        alias /code/static/;
    }
    location /media/ {
        alias /code/media/;
    }
}