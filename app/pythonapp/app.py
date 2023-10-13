from flask import Flask, render_template
import os
app = Flask(__name__)

@app.route("/")
def hello():
    bucket_name = os.environ.get("bucket_name")
    path = os.environ.get("path")
    return render_template('index.html', bucket_name=bucket_name, path=path)
    # return f'Hello, World! from {architecture} architecture'
