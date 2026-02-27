# chromedp-headless-sheel-ko

`chromedp/headless-shell` 이미지를 기반으로
한국어 폰트(`fonts-noto-cjk`)가 포함된 경량 헤드리스 브라우저 이미지입니다.

## 빌드

```bash
# 로컬에서 단일 아키텍처로 빌드
docker build -t chromedp-headless-shell-ko:local .

# 멀티 아키텍처(amd64, arm64) 빌드 테스트
docker buildx build --platform linux/amd64,linux/arm64 \
    -t chromedp-headless-shell-ko:local --load .
```

## 환경 변수

이미지는 기본 헤더 값을 몇 가지 환경 변수로 노출합니다. 이들은 `Dockerfile`
의 `ENV`로 설정되어 있으며, 실행 시 `-e` 플래그로 쉽게 덮어쓸 수 있습니다.

* `DEFAULT_USER_AGENT` – 컨테이너가 주입할 기본 `--user-agent` 값
* `DEFAULT_ACCEPT_LANGUAGE` – 기본 `--accept-language` (기본은
  `ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7`)
* `USER_AGENT`/`ACCEPT_LANGUAGE` – 런타임에 각각을 직접 지정할 때 사용

이 변수들은 커맨드라인에서 직접 `--user-agent`/`--accept-language` 플래그가
전달되면 무시됩니다.


## 실행 예제

```bash
# 가장 간단하게는 이미지에 내장된 헤드리스 셸 바이너리를 직접 호출합니다.
# entrypoint가 UA/AL 플래그를 자동 주입하므로 별도로 지정할 필요가 없습니다.

docker run --rm chromedp-headless-shell-ko:local \
    --headless --disable-gpu --screenshot https://www.naver.com
```

기본적으로 컨테이너는 한국어 우선 `Accept-Language` 헤더를 설정합니다:

```
Accept-Language: ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7
```

원한다면 이미지 빌드 시 `DEFAULT_ACCEPT_LANGUAGE` 또는 런타임에
`ACCEPT_LANGUAGE`/`USER_AGENT` 환경 변수를 조정하거나 직접 Chrome
플래그(예. `--accept-language=…`, `--user-agent=…`)를 전달할 수 있습니다.

```bash
# 런타임 헤더 재정의 예
docker run --rm -e ACCEPT_LANGUAGE="en-US,en;q=0.9" chromedp-headless-shell-ko:local \
    google-chrome-stable --headless --disable-gpu --screenshot https://example.com
```

## 자동화

커밋이나 태그를 `main` 브랜치에 푸시하면
`.github/workflows/docker-publish.yml`이 트리거되어
GitHub Container Registry(GHCR)에 멀티아키텍처 이미지를 자동으로 빌드/배포합니다.
