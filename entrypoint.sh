#!/bin/bash
set -e

# Base image (chromedp/headless-shell) runs socat first
socat TCP4-LISTEN:9222,fork TCP4:127.0.0.1:9223 &

# Execute headless-shell directly, skipping run.sh to avoid its word splitting ($@ vs "$@") on space-containing args like USER_AGENT
exec /headless-shell/headless-shell \
    --no-sandbox \
    --use-gl=angle \
    --use-angle=swiftshader \
    --remote-debugging-address=0.0.0.0 \
    --remote-debugging-port=9223 \
    --disable-setuid-sandbox \
    --disable-dev-shm-usage \
    --disable-accelerated-2d-canvas \
    --no-first-run \
    --no-zygote \
    --disable-gpu \
    --disable-web-security \
    --disable-features=VizDisplayCompositor,TranslateUI,BlinkGenPropertyTrees \
    --disable-background-timer-throttling \
    --disable-backgrounding-occluded-windows \
    --disable-renderer-backgrounding \
    --disable-blink-features=AutomationControlled \
    --disable-extensions-except \
    --disable-plugins-discovery \
    --disable-session-crashed-bubble \
    --disable-infobars \
    --disable-notifications \
    --disable-default-apps \
    --disable-popup-blocking \
    --disable-translate \
    --disable-images \
    --disable-javascript-harmony-shipping \
    --disable-background-networking \
    --disable-sync \
    --disable-component-extensions-with-background-pages \
    --disable-background-mode \
    --disable-client-side-phishing-detection \
    --disable-hang-monitor \
    --disable-prompt-on-repost \
    --disable-domain-reliability \
    --disable-ipc-flooding-protection \
    --window-size=800,600 \
    --disable-software-rasterizer \
    --run-all-compositor-stages-before-draw \
    --disable-threaded-animation \
    --disable-threaded-scrolling \
    --disable-checker-imaging \
    --disable-new-content-rendering-timeout \
    --disable-image-animation-resync \
    --disable-partial-raster \
    --disable-skia-runtime-opts \
    --memory-pressure-off \
    --max_old_space_size=4096 \
    --lang=ko_KR \
    --user-agent="${DEFAULT_USER_AGENT}" \
    "$@"
