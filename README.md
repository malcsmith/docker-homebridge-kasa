
# docker: homebridge (with kasa plugin)
This is a docker image to run the [homebridge tool](https://github.com/nfarina/homebridge) with the 
[homebridge-indigo plugin](https://www.npmjs.com/package/homebridge-indigo) enabled.

Adapted from https://github.com/moutten/docker-homebridge 

### Build from docker file

If you want to build the docker container image yourself you can do so with the
following commands:

```bash
git clone git@github.com:malcsmith/docker-homebridge-kasa.git
cd docker-homebridge-kasa
docker build -t homebridge .
```



### Running the image

In order to run the homebridge server command in daemonized mode, use the following:

```bash
docker run -d --net="host" -v /PATH_TO_HOMEBRIDGE_CONFIG_DIRECTORY:/config malcsmith/homebridge
```

