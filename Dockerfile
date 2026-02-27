# 프로젝트 루트에 위치합니다.
# - chromedp/headless-shell을 베이스로 사용
# - 한글 폰트 설치를 위해 root 권한을 획득합니다.
FROM chromedp/headless-shell:latest

# -------------------------------------------------------------
# 한글 폰트 및 로케일 설정

# font-noto-cjk는 CJK(중국어/일본어/한국어)용 Noto 폰트 패키지
# locales는 다국어 로케일 지원을 위한 패키지
RUN apt-get update && apt-get install -y --no-install-recommends \
    fonts-noto-cjk \
    locales \
    && rm -rf /var/lib/apt/lists/*

# 한글 로케일 생성 (ko_KR.UTF-8)
RUN sed -i 's/^# ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen ko_KR.UTF-8

# 환경 변수 설정
ENV LANG=ko_KR.UTF-8 \
    LANGUAGE=ko_KR:ko \
    LC_ALL=ko_KR.UTF-8

