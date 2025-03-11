vcl 4.1;
import directors;

# Default backend definition. Set this to point to your content server.
backend default_backend {
    .host = "test_apache";
    .port = "80";
}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.
    set req.backend_hint = default_backend;
    if (req.url ~ "^/admin" || req.http.Authorization){
        return (pass);
    }
    return(hash);
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend do
   if(beresp.status == 200 || beresp.status == 301 || beresp.status == 302){
        set beresp.ttl = 1h;
    } else {
        set beresp.ttl = 0s;
    }

    if (beresp.http.Content-Type ~ "text/(html|css|javascript)") {
        set beresp.do_gzip = true;
    }

    if(beresp.http.Content-type ~ "image/*"){
        set beresp.ttl = 1d;
    }
    return(deliver);
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
    if(obj.hits > 0) {
        set resp.http.X-Cache = "HIT";
    } else {
        set resp.http.X-Cache = "MISS";
    }
    return(deliver);
}
