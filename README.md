# Boot.dev CLI Container

A Docker container for the [Boot.dev CLI](https://github.com/bootdotdev/bootdev) with development tools pre-installed.

## Quick Start

**Interactive shell:**
```bash
docker build -t bootdev-cli .
docker run -it bootdev-cli
```

Then inside the container:
```bash
bootdev login
bootdev run <lesson-id>
bootdev submit
```

**Run single commands:**
```bash
docker run --rm bootdev-cli bootdev --version
docker run --rm bootdev-cli git --version
```

## Included Tools

- bootdev CLI
- Git, Curl, Wget
- Make, GCC
- Python 3.11
- Build essentials

## Pull from GitHub Container Registry

```bash
docker pull ghcr.io/kelleyblackmore/bootdev-ci:main
docker run -it ghcr.io/kelleyblackmore/bootdev-ci:main
```

## License

MIT