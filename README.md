## oauth2_proxy dockerization

This is a Dockerization of the handy dandy
[bitly OAuth Proxy](https://github.com/bitly/oauth2_proxy).

Check out the bitly github page for more details on the different command line
options that can be passed in.

This is also an automated
[Docker Hub build](https://registry.hub.docker.com/u/nlopez/google-auth-proxy/)

### Quickstart with Docker Compose
First, configure your client secret/id/cookie secret in the `docker-compose.yml` file
and replace all references to `example.com` with your domain.

Then simply run:

    docker-compose up

The container will be built and an nginx proxy automatically configure to
connect to the oauth2 proxy. Navigate to http://(docker ip)/ping to check
out whether the proxy is up and running.

You will be asked to authenticated and if successful, redirected to the upstream
nginx container serving a simple HTML page.

### Quickstart without Docker Compose

The following example assumes you have your upstream host located at `upstream:80`

    docker run -P nlopez/oauth2_proxy \
        --cookie-secure=false \
        --upstream="http://upstream:80" \
        --http-address="0.0.0.0:4180" \
        --redirect-url="http://example.com/oauth2/callback" \
        --email-domain="example.com" \
        --cookie-secret=<cookie-secret> \
        --client-id=<client-id> \
        --client-secret=<client-secret>

## Configuration
By default I set the upstream and http-address to the following:

    --upstream=http://0.0.0.0:8080/
    --http-address=0.0.0.0:4180

This allows us to easily configure our upstream or nginx proxy to those addresses.

### Environment Variables
Alternatively you can set the cookie-secret, client-id, and/or client-secret as
environment variables using the following variables below:

    OAUTH2_PROXY_COOKIE_SECRET     # The seed string for secure cookies
    OAUTH2_PROXY_CLIENT_ID         # The Google OAuth Client ID
    OAUTH2_PROXY_CLIENT_SECRET     # The Google OAuth Client Secret

### Example Usage w/ environment variables
    docker run -e OAUTH2_PROXY_COOKIE_SECRET=<cookie-secret> \
        -e OAUTH2_PROXY_CLIENT_ID=<client-id> \
        -e OAUTH2_PROXY_CLIENT_SECRET=<client-secret> \
        nlopez/oauth2_proxy
