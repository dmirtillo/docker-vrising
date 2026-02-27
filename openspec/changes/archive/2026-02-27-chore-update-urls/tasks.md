## 1. Documentation Updates

- [x] 1.1 Update repository URL in `README.md` to `github.com/dmirtillo/docker-vrising`
- [x] 1.2 Update image badges and links in `README.md` to `dmirtillo/vrising-dedicated`
- [x] 1.3 Update Docker image references in `docs/installation.md` (Docker Compose and CLI examples)
- [x] 1.4 Scan all other documentation in `docs/` and replace any `trueosiris` occurrences with `dmirtillo`

## 2. CI/CD Updates

- [x] 2.1 Update the Docker Hub repository variable or hardcoded path in `.github/workflows/docker-image.yml`
- [x] 2.2 Verify that the `publish` job correctly targets `dmirtillo/vrising-dedicated`

## 3. Cleanup and Verification

- [x] 3.1 Perform a global search for the string `trueosiris` across the entire project
- [x] 3.2 Ensure all occurrences are either removed or updated to `dmirtillo`
- [x] 3.3 Verify all modified links in `README.md` and `docs/` are correctly formatted
