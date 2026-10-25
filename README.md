# captcha-skill-sidecar

Container wrapper for [Wawanahayy/captcha-skill](https://github.com/Wawanahayy/captcha-skill)
pinned at commit `043edcd8a12da03d86aa3a8b785ef926a75adea1`.

Deployed as a sibling service (`captcha-solver`) in the Railway project
Aidcos-stealth, listening internally on :8001. It ships DARK under the
stealth hardening package's CAPTCHA Phase 2: the main stealth-browser-mcp
service does not call it and `CAPTCHA_SOLVER_ENABLED` stays `false` there
until the reCAPTCHA-demo acceptance for the in-service solver passes.

The image is public because it contains only the public upstream code and
no credentials or fleet configuration; the service gets no public domain.
