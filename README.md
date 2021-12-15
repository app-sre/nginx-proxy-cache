This is a simple nginx container that can be used to redirect all incoming traffic to another URL.

## Running nginx-redirector

    docker run --name=nginx-redirector -p 8080:80 -d \
        -e REDIRECTOR_DESTINATION=http://some-domain.com \
        -e REDIRECTOR_TYPE=redirect \
        jfchevrette/nginx-redirector

_REDIRECTOR_TYPE_ can be set to either **redirect** or **permanant**

## Running nginx-redirector on openshift

    oc run redirector \
        --image=jfchevrette/nginx-redirector \
        --env=REDIRECTOR_DESTINATION=http://some-domain.com \
        --env=REDIRECTOR_TYPE=redirect
        --expose --port=8080
        
    oc expose svc redirector
