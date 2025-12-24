# Boot.dev CLI Container

A Docker container image for the [Boot.dev CLI](https://github.com/bootdotdev/bootdev) with all necessary tools for course work.

## Features

- **bootdev CLI v1.22.0** - Official Boot.dev command-line tool
- **Development Tools** - Git, Curl, Wget, Make, GCC, Python 3.11, and build essentials
- **GitHub Actions workflow** for automated container builds and pushes to ghcr.io
- **Multi-architecture support** via Docker Buildx
- **Interactive bash shell** for workspace environment

## Quick Start

### Run Interactively

```bash
docker run -it bootdev-cli
```

This starts an interactive bash shell where you can:
- Run `bootdev login` to authenticate with your Boot.dev account
- Run `bootdev run <lesson-id>` to run lessons
- Run `bootdev submit` to submit completed lessons
- Use any installed tools (git, python, make, curl, gcc, etc.)

### Run Individual Commands

```bash
docker run --rm bootdev-cli bootdev --version
docker run --rm bootdev-cli git --version
docker run --rm bootdev-cli python3 --version
```

### Pull from GitHub Container Registry

```bash
docker pull ghcr.io/kelleyblackmore/bootdev-ci:main
docker run -it ghcr.io/kelleyblackmore/bootdev-ci:main
```

## Installed Tools

The container includes:
- **bootdev CLI** - Official Boot.dev command-line tool
- **Git** v2.43.7 - Version control and cloning repositories
- **Curl** v8.14.1 - HTTP client for API testing
- **Wget** - Alternative download tool
- **Make** v4.4.1 - Build automation
- **GCC** v13.2.1 - C/C++ compiler
- **Python** v3.11.14 - Python runtime
- **Bash** & **sh** - Shell environments
- **Build essentials** - Build tools and libraries

## Testing All Tools

```bash
docker run --rm bootdev-cli bootdev --version && \
docker run --rm bootdev-cli git --version && \
docker run --rm bootdev-cli curl --version 2>&1 | head -1 && \
docker run --rm bootdev-cli make --version 2>&1 | head -1 && \
docker run --rm bootdev-cli python3 --version && \
docker run --rm bootdev-cli gcc --version 2>&1 | head -1
```

## Workflow Triggers

The workflow runs on:
- Push to `main` branch
- Tags matching `v*` pattern (e.g., `v1.0.0`)
- Pull requests to `main` branch (builds but does not push)
- Manual dispatch via GitHub Actions UI

## Image Tags

The workflow automatically generates the following tags:
- Branch name (e.g., `main`)
- Pull request number (e.g., `pr-123`)
- Semantic version from git tag (e.g., `1.0.0`, `1.0`)
- Git SHA (e.g., `sha-a1b2c3d`)

## Pulling Your Image

Once built, you can pull your image using:

```bash
docker pull ghcr.io/kelleyblackmore/bootdev-ci:TAG
```

Replace `TAG` with the desired tag (e.g., `main`, `v1.0.0`, or `sha-a1b2c3d`).

## Configuration

### Required Permissions

The workflow requires the following permissions (already configured):
- `contents: read` - To checkout the repository
- `packages: write` - To push to GitHub Container Registry

### Making Your Package Public

By default, container images are private. To make them public:
1. Go to your repository's "Packages" section
2. Select your container image
3. Go to "Package settings"
4. Change visibility to "Public"

## License

MIT