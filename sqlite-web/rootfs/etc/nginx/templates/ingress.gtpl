server {
    listen 8099 default_server;

    include /etc/nginx/includes/server_params.conf;
    include /etc/nginx/includes/proxy_params.conf;

    location / {
        allow   172.30.32.2;
        deny    all;

        proxy_pass http://sqlite;

        sub_filter_once off;
        sub_filter 'href="/' 'href="{{ .entry }}/';
        sub_filter '/static/' '{{ .entry }}/static/';
        sub_filter '/event_data/' '{{ .entry }}/event_data/';
        sub_filter '/events/' '{{ .entry }}/events/';
        sub_filter '/recorder_runs/' '{{ .entry }}/recorder_runs/';
        sub_filter '/schema_changes/' '{{ .entry }}/schema_changes/';
        sub_filter '/state_attributes/' '{{ .entry }}/state_attributes/';
        sub_filter '/states/' '{{ .entry }}/states/';
        sub_filter '/statistics/' '{{ .entry }}/statistics/';
        sub_filter '/statistics_meta/' '{{ .entry }}/statistics_meta/';
        sub_filter '/statistics_runs/' '{{ .entry }}/statistics_runs/';
        sub_filter '/statistics_short_term/' '{{ .entry }}/statistics_short_term/';
    }
}
