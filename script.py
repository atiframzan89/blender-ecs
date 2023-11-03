from datetime import datetime
import os
import sys

import boto3
import bpy


#argv = sys.argv
#print(argv)
#argv = argv[argv.index("--") + 1:]
argv = [1,1]
s3 = boto3.resource("s3")
SOURCE_BUCKET_NAME = "source-blender"
DESTINATION_BUCKET_NAME = "destination-blender"
#filename = f"{datetime.now().strftime('%Y_%m_%d-%I:%M:%S_%p')}.png"
filename = "outputfile.jpg"
s3.Bucket(SOURCE_BUCKET_NAME).download_file("scenes/scene.blend", "/tmp/scene.blend")

bpy.ops.wm.open_mainfile(filepath="/tmp/scene.blend", load_ui=False)
bpy.context.scene.render.filepath = f"/tmp/{filename}"
bpy.context.scene.render.resolution_x = int(argv[0])
bpy.context.scene.render.resolution_y = int(argv[1])
bpy.ops.render.render(write_still = True)

s3.Bucket(DESTINATION_BUCKET_NAME).upload_file("/tmp/"+filename, "renders/"+filename)
