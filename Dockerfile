FROM python:3.11-slim

# CAPTCHA solver sidecar (hardening package Phase 2, shipped dark).
# Wraps Wawanahayy/captcha-skill at a pinned commit as a container service
# listening on :8001. The main stealth service does not call it until the
# reCAPTCHA-demo acceptance passes and CAPTCHA_SOLVER_ENABLED is turned on
# there; this image carries no credentials and no fleet configuration.

ARG CAPTCHA_SKILL_REF=043edcd8a12da03d86aa3a8b785ef926a75adea1

RUN apt-get update && apt-get install -y --no-install-recommends \
        git ca-certificates \
        libgtk-3-0 libdbus-glib-1-2 libasound2 libx11-xcb1 libxcomposite1 \
        libxdamage1 libxrandr2 libgbm1 libpango-1.0-0 libcairo2 libatk1.0-0 \
        libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxfixes3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN git clone https://github.com/Wawanahayy/captcha-skill.git . \
    && git checkout ${CAPTCHA_SKILL_REF}

RUN pip install --no-cache-dir fastapi "uvicorn[standard]" loguru camoufox \
    && python -m camoufox fetch

EXPOSE 8001
CMD ["python", "run_captcha_solver.py"]
