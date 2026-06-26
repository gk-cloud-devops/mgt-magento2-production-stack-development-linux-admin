vcl 4.1;

import std;

backend default {
    .host = "127.0.0.1";
    .port = "8080"; # Correctly targets backend Nginx processing loops
    .first_byte_timeout = 600s;
}

sub vcl_recv {
    # Set standard forwarded protocol checks for secure application pipelines
    if (req.http.X-Forwarded-Proto == "https") {
        set req.http.X-Forwarded-Port = "443";
    }
    
    # Bypass structural asset checks directly to backend pools if required
    if (req.method != "GET" && req.method != "HEAD" && req.method != "PUT" && req.method != "POST") {
        return (pipe);
    }
    
    return (hash);
}

sub vcl_backend_response {
    # Custom TTL buffer optimization configurations
    if (beresp.status == 200) {
        set beresp.ttl = 86400s;
    }
}

sub vcl_deliver {
    # Expose custom debugging headers to track proxy performance validation loops
    if (obj.hits > 0) {
        set resp.http.X-Varnish-Cache = "HIT";
    } else {
        set resp.http.X-Varnish-Cache = "MISS";
    }
}
