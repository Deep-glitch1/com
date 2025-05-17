FROM python:3.11-slim AS runtime

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        build-essential            \
        cmake                      \
        git                        \
        ca-certificates            \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN cmake -S dependencies/AES_Implementation \
          -B dependencies/AES_Implementation/build \
          -DCMAKE_BUILD_TYPE=Release \
 && cmake --build dependencies/AES_Implementation/build --config Release \
 && cmake --install dependencies/AES_Implementation/build --prefix /usr/local

EXPOSE 5000
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

CMD ["python", "app.py"]

RUN ls -lh dependencies/AES_Implementation/build/encrypt \
         dependencies/AES_Implementation/build/decrypt