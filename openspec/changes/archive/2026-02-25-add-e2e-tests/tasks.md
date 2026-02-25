## 1. Test Script Implementation

- [x] 1.1 Create `scripts/test-startup.sh` and make it executable
- [x] 1.2 Implement Docker build and `docker run` detached execution inside the script
- [x] 1.3 Implement a log polling loop with a 10-minute timeout searching for "Startup Completed"
- [x] 1.4 Add an `exit` trap to ensure the test container is forcefully removed upon script exit
- [x] 1.5 Ensure the script exits with `0` on success and `1` on timeout/failure

## 2. CI/CD Integration

- [x] 2.1 Update `.github/workflows/docker-image.yml` to execute `scripts/test-startup.sh` on PRs and pushes to `main`
- [x] 2.2 Add a step in the GitHub Actions workflow to output container logs if the test script fails