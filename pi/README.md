### Running the WebView project on target devices

```bash
# $PI_MODEL can be one of the following: pi1, pi2, pi3, pi4
TARGET_DEVICE=$PI_MODEL ./scripts/generate_dockerfile.sh && \
    docker compose down && \
    docker compose up --build
```
