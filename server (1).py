import socket
import threading
from transformers import AutoImageProcessor, AutoModelForImageClassification
import torch
import numpy as np
from PIL import Image
import io
import base64


image_processor = AutoImageProcessor.from_pretrained('kimitoinf/dedc')
model = AutoModelForImageClassification.from_pretrained('kimitoinf/dedc')

def handler(client):
    # Receive the length of the image data
    length = int(client.recv(16).decode('utf-8').strip())
    client.send('received'.encode('utf-8'))
    print(112)
    # Receive the actual image data
    image_data = client.recv(length)
    print(112)
    image = Image.open(io.BytesIO(base64.b64decode(image_data)))
    print(112)
    input = image_processor(image, return_tensors='pt')
    
    with torch.no_grad():
        logits = model(**input).logits
        prediction = logits.argmax(-1).item()
        client.send(model.config.id2label[prediction].encode('utf-8'))
    
    client.close()

SERVER = 'localhost'  # socket.gethostbyname(socket.gethostname())
PORT = 5000
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((SERVER, PORT))
server.listen()
print(f'Server is listening on {SERVER}:{PORT}.')

clients = []
while True:
    connect, address = server.accept()
    clients.append(connect)
    print(f'Client {address} is connected.')
    thread = threading.Thread(target=handler, args=(connect,))
    thread.start()
