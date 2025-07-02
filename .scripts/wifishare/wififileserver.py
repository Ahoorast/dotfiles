import os
import subprocess
from flask import Flask, send_from_directory, abort, request, Response
# import ffmpeg
# from flask_video_streaming import VideoStreaming

app = Flask(__name__)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve_path(path):
    execution_dir = os.getcwd()
    full_path = os.path.join(execution_dir, path)

    if os.path.isfile(full_path):
        mime_type = get_mime_type(full_path)
        if mime_type == 'video/x-matroska':
            hashed_filename = hash(full_path)
            output_path = f'/home/ahoora/.scripts/wifishare/converted/{hashed_filename}.mp4'
            print("PLEEEEEEEEAAAASEEEEE", output_path, os.path.exists(output_path))
            if not os.path.exists(output_path):
                # ffmpeg.input(full_path).output(output_path).run()
                subprocess.run(
                    ["ffmpeg", "-i", full_path, "-codec", "copy", output_path], check=True
                )

            return send_from_directory(os.path.dirname(output_path), os.path.basename(output_path), conditional=True)
        return send_from_directory(os.path.dirname(full_path), os.path.basename(full_path), conditional=True)

    elif os.path.isdir(full_path):
        files = os.listdir(full_path)
        file_links = ''.join(f'<li><a href="/{os.path.join(path, file)}">{file}</a></li>' for file in files)
        upload_form = '''
            <form action="/upload" method="post" enctype="multipart/form-data">
                <input type="file" name="file">
                <input type="submit" value="Upload">
            </form>
        '''
        return f'<ul>{file_links}</ul>{upload_form}<a href="https://berlin.saymyname.website/Movies/2023/23561236/American_Fiction_2023_1080p_WEB-DL_YIFY.mp4">Dune</a>'
    else:
        abort(404)

@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    path = 'upload_bucket'
    if file and path:
        execution_dir = os.getcwd()
        full_path = os.path.join(execution_dir, path, file.filename if file.filename else 'untitled')
        file.save(full_path)
        return f'File {file.filename} uploaded successfully to {path}.'
    else:
        abort(400)

def get_mime_type(file_path):
    extension = os.path.splitext(file_path)[1].lower()
    if extension == '.mp4':
        return 'video/mp4'
    elif extension == '.mkv':
        return 'video/x-matroska'
    else:
        return None

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
