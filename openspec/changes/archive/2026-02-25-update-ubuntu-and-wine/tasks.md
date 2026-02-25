## 1. Infrastructure & Repository Setup

- [x] 1.1 Update `FROM` instruction in `Dockerfile` to `ubuntu:24.04`.
- [x] 1.2 Add commands to create `/etc/apt/keyrings` directory and download the WineHQ GPG key.
- [x] 1.3 Configure the WineHQ APT repository source for Ubuntu 24.04 (noble).

## 2. Package Management & Installation

- [x] 2.1 Update the `apt-get install` block to remove the default `wine` package.
- [x] 2.2 Add `winehq-stable` to the list of packages to be installed.
- [x] 2.3 Review and update other package dependencies for compatibility with Ubuntu 24.04.
- [x] 2.4 Ensure `i386` architecture is still correctly enabled before repository updates.

## 3. Verification & Cleanup

- [x] 3.1 Build the Docker image to ensure the multi-step `RUN` layer succeeds.
- [x] 3.2 Verify `wine --version` output within a running container instance.
- [x] 3.3 Conduct a smoke test by starting the container and checking `start.sh` execution logs.
