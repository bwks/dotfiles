---
name: r2-push
description: Push files to Cloudflare R2 storage. Use when the user wants to upload files, sync a directory, or publish assets to R2.
argument-hint: <file-or-directory> [bucket/prefix]
allowed-tools: Bash
---

Push files to Cloudflare R2 storage using the AWS CLI with S3-compatible endpoint.

- **Source**: `$ARGUMENTS[0]` (required — file path, directory, or glob pattern)
- **Destination**: `$ARGUMENTS[1]` (optional — `bucket-name/prefix`. If only a bucket is given, files go to the root. If omitted, prompt the user.)

## Prerequisites

This skill uses the AWS CLI (`aws`) with R2's S3-compatible API. The following environment variables must be set:

| Variable | Purpose |
|---|---|
| `R2_ENDPOINT_URL` | R2 endpoint, e.g. `https://<account-id>.r2.cloudflarestorage.com` |
| `R2_ACCESS_KEY_ID` | R2 API token access key |
| `R2_SECRET_ACCESS_KEY` | R2 API token secret key |

If any are missing, inform the user and stop. Do NOT fall back to interactive auth or default credentials.

## Steps

1. **Check prerequisites**: Verify `aws` CLI is installed and the three `R2_*` environment variables are set. If anything is missing, tell the user what to install or export and stop.

2. **Resolve source**: Verify the source path exists. If it's a glob, expand it. If nothing matches, inform the user and stop.

3. **Parse destination**: Split the destination into bucket name and optional prefix. If no destination was provided, ask the user for the bucket name.

4. **Upload**:
   - For a single file:
     ```
     aws s3 cp <file> s3://<bucket>/<prefix>/<filename> \
       --endpoint-url "$R2_ENDPOINT_URL" \
       --region auto
     ```
   - For a directory:
     ```
     aws s3 sync <directory> s3://<bucket>/<prefix> \
       --endpoint-url "$R2_ENDPOINT_URL" \
       --region auto
     ```

   Always pass credentials via environment variables on the command:
   ```
   AWS_ACCESS_KEY_ID="$R2_ACCESS_KEY_ID" \
   AWS_SECRET_ACCESS_KEY="$R2_SECRET_ACCESS_KEY" \
   aws s3 ...
   ```

5. **Confirm**: Print the uploaded file(s) and their S3 URI(s). If a public bucket URL is known, print that too.

## Options

The user may request these — apply only when asked:

- `--delete`: Pass `--delete` to `s3 sync` to remove remote files not present locally.
- `--dry-run`: Pass `--dryrun` to preview what would be uploaded without actually uploading.
- `--content-type`: Pass `--content-type <type>` to override the MIME type.
- `--cache-control`: Pass `--cache-control <value>` to set caching headers.

## Error handling

- If credentials are invalid (403), inform the user to check their R2 API token.
- If the bucket doesn't exist (404/NoSuchBucket), inform the user and suggest creating it first.
- If the upload fails for other reasons, show the error output and suggest retrying.
