# 프로젝트 루트에 위치합니다.
# - chromedp/headless-shell을 베이스로 사용
# - 한글 폰트 설치를 위해 root 권한을 획득합니다.
FROM chromedp/headless-shell:latest

# -------------------------------------------------------------
# 한글 폰트 설치

# font-noto-cjk는 CJK(중국어/일본어/한국어)용 Noto 폰트 패키지
RUN apt-get update && apt-get install -y --no-install-recommends \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

