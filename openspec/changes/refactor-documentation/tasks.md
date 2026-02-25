## 1. Directory Setup

- [x] 1.1 Create `docs/` directory in the root of the repository.

## 2. Content Extraction

- [x] 2.1 Create `docs/installation.md` and move Docker CLI and Docker Compose sections into it.
- [x] 2.2 Create `docs/configuration.md` and move Environment variables, "Newest modifications" (dynamic JSON config), and RCON sections into it.
- [x] 2.3 Create `docs/networking.md` and move Ports table and networking-related "Remarks" (e.g., custom ports, port forwarding) into it.
- [x] 2.4 Create `docs/data-management.md` and move Volumes table and save/migration "Remarks" into it.
- [x] 2.5 Create `docs/troubleshooting.md` and move Windows host exceptions, `fixme:winsock` log warnings, and long startup time notices into it.

## 3. Landing Page Refactor

- [x] 3.1 Update `README.md` to remove the extracted content.
- [x] 3.2 Add a clean "Documentation Index" section to `README.md` with relative links to all the new files in the `docs/` folder.
- [x] 3.3 Ensure all internal document cross-references use correct relative linking (e.g., `installation.md` linking to `networking.md`).