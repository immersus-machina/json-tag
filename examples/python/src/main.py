import json

import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import Response

from shape_service import generate_random_shape

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/shape")
def get_shape():
    shape = generate_random_shape()
    shape_data = json.loads(shape.to_json())
    response_body = json.dumps({"shape": shape_data, "sender": "Python"})
    return Response(content=response_body, media_type="application/json")


if __name__ == "__main__":
    print("JSON# Python backend listening on port 57660")
    uvicorn.run(app, host="0.0.0.0", port=57660, log_level="warning")
