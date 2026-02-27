## 1. Dockerfile Updates

- [x] 1.1 Add `WINE_VERSION` argument to `Dockerfile` with the current latest candidate.
- [x] 1.2 Update the `winehq-stable` apt-get install command to use the pinned version argument.
- [x] 1.3 Add `VRISING_BUILD_ID` argument to `Dockerfile` with a current dummy/real value.
- [x] 1.4 Test the Docker image build locally to ensure the explicit version tracking doesn't break the build.

## 2. GitHub Actions: Wine Update Check

- [x] 2.1 Create `.github/workflows/update-wine.yml` workflow file.
- [x] 2.2 Configure the workflow to run on a monthly schedule (e.g., 1st of the month at midnight).
- [x] 2.3 Implement the job steps to check for the latest WineHQ release using `apt-cache policy`.
- [x] 2.4 Add steps to parse the `Dockerfile`, compare versions, update if necessary, and use `peter-evans/create-pull-request` to create a PR.

## 3. GitHub Actions: V Rising Update Check

- [x] 3.1 Create `.github/workflows/update-vrising.yml` workflow file.
- [x] 3.2 Configure the workflow to run on a weekly schedule (e.g., Sunday at midnight).
- [x] 3.3 Implement the job steps to query the SteamCMD Web API for the latest `buildid`.
- [x] 3.4 Add steps to parse the `Dockerfile`, compare build IDs, update if necessary, and use `peter-evans/create-pull-request` to create a PR.

## 4. Documentation

- [x] 4.1 Update `CHANGELOG.md` with notes about explicit version tracking and automated update workflows.
- [x] 4.2 Update `README.md` or `docs/development.md` to explain how dependency updates are managed via automated PRs.
