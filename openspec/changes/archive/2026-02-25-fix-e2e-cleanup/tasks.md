## 1. Test Script Cleanup Fix

- [x] 1.1 Modify the `cleanup` function in `scripts/test-startup.sh`.
- [x] 1.2 Add a `docker run` command using `ubuntu:24.04` to mount `$TEST_DIR` and delete its contents as root (`rm -rf /test_dir/* /test_dir/.*`).
- [x] 1.3 Ensure the host `rm -rf "$TEST_DIR"` executes successfully after the container cleans the contents.