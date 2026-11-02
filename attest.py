import requests

BASE_URL = "http://localhost:8080"

def make_payload(prefix):
    return {
        "page": f"{prefix} Page", "title": f"{prefix} Title",
        "context": f"{prefix} Context",
        "page_vector": [0.1]*10, "title_vector": [0.2]*10,
        "context_vector": [0.3]*10
    }

def test_add_page():
    payload = make_payload("Test")
    response = requests.post(f"{BASE_URL}/at_data/", json=payload)
    assert response.status_code == 201
    new_id = response.json()["id"]

    response = requests.get(f"{BASE_URL}/at_data/{new_id}")
    assert response.status_code == 200
    data = response.json()
    assert data["title"] == payload["title"]

    requests.delete(f"{BASE_URL}/at_data/{new_id}")