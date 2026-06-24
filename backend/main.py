from fastapi import FastAPI
from pydantic import BaseModel
import re

app = FastAPI()

class URLRequest(BaseModel):
    url: str


def predict_phishing(url):
    score = 0
    reasons = []

    url_lower = url.lower()

    phishing_flag = False

    if "@" in url:
        phishing_flag = True
        reasons.append("URL contains @ redirect trick")

    if re.match(r"http[s]?://\d+\.\d+\.\d+\.\d+", url_lower):
        phishing_flag = True
        reasons.append("Uses raw IP instead of domain")

    if "login" in url_lower and "http://" in url_lower:
        score += 50
        reasons.append("Login page without secure HTTPS")

    if url_lower.startswith("http://"):
        score += 25
        reasons.append("Not using HTTPS")

    suspicious_keywords = ["verify", "update", "secure", "bank", "account", "password"]
    for k in suspicious_keywords:
        if k in url_lower:
            score += 12
            reasons.append(f"Suspicious keyword detected: {k}")

    if len(url) > 75:
        score += 15
        reasons.append("Abnormally long URL")

    # FINAL CLASSIFICATION
    if phishing_flag or score >= 70:
        label = "PHISHING"
    elif score >= 40:
        label = "SUSPICIOUS"
    else:
        label = "SAFE"

    confidence = min(score, 100)

    # ✅ IMPORTANT FIX
    return label, confidence, reasons


@app.post("/predict")
def predict(data: URLRequest):
    label, confidence, reasons = predict_phishing(data.url)

    return {
        "label": label,
        "confidence": confidence,
        "reasons": reasons
    }