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
    LC_ALL=ko_KR.UTF-8 \
    # 기본 User-Agent (필요시 실행 시 덮어쓰기 가능)
    DEFAULT_USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

# 엔트리포인트 스크립트 추가 및 실행 권한 부여
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# 기본 실행
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/headless-shell/headless-shell"]

