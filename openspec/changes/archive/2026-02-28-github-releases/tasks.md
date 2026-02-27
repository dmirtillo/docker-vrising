## 1. Workflow Updates

- [x] 1.1 Add a script step to `.github/workflows/docker-image.yml` to extract the latest release notes from `CHANGELOG.md`.
- [x] 1.2 Add the `softprops/action-gh-release@v2` step to `.github/workflows/docker-image.yml` to create the GitHub release using the extracted notes.