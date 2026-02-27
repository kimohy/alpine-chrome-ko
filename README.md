# alpine-chrome-ko

Zenika의 `alpine-chrome:stable` 이미지를 기반으로
한국어 폰트(`font-noto-cjk`)가 포함된 경량 헤드리스 크롬 이미지입니다.

## 빌드

```bash
# 로컬에서 단일 아키텍처로 빌드
docker build -t alpine-chrome-ko:local .

# 멀티 아키텍처(amd64, arm64) 빌드 테스트
docker buildx build --platform linux/amd64,linux/arm64 \
    -t alpine-chrome-ko:local --load .
```

## 실행 예제

```bash
docker run --rm alpine-chrome-ko:local \
    google-chrome-stable --headless --disable-gpu --screenshot https://www.naver.com
```

## 자동화

커밋이나 태그를 `main` 브랜치에 푸시하면
`.github/workflows/docker-publish.yml`이 트리거되어
GitHub Container Registry(GHCR)에 멀티아키텍처 이미지를 자동으로 빌드/배포합니다.
