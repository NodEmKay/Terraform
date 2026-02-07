# Terraform Null Resource Examples

This folder demonstrates practical uses of Terraform's `null_resource` with various provisioner and trigger patterns.

## Examples

### 1. local-exec
- Runs a local command and writes a timestamped message to `local-exec.txt`.
- Useful for automating local scripts or file creation.

### 2. file-trigger
- Watches `somefile.txt` for changes using `filebase64sha256`.
- Appends a timestamped line to `file-trigger.txt` whenever the file changes.
- Useful for tracking file modifications and triggering actions.

### 3. timestamp
- Uses `timestamp()` in triggers to force execution on every `terraform apply`.
- Appends the current date and time to `timestamp.txt` for each apply.
- Useful for logging, auditing, or repeated automation steps.

### 4. external-api
- Calls an external API (httpbin.org) with a POST request using `curl`.
- Saves the response to `external-api-response.txt`.
- Useful for triggering webhooks, notifications, or integrating with external systems.

## How to Use
1. Navigate to the desired example directory.
2. Run `terraform init` to initialize.
3. Run `terraform apply` to test the example.
4. Check the output files for results.

## Customization
- You can modify commands, file paths, or API endpoints to fit your workflow.
- Add triggers to force execution or track changes as needed.

---
For more advanced automation, combine these patterns or integrate with other Terraform resources and modules.
