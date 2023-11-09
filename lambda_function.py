import json
import os

def lambda_handler():
    os.system(f"./blender -b -P script.py")
    #os.system(f"./blender -b -P script.py -- {event.get('width', 0)} {event.get('height', 0)}")
    os.system(f"ls -ltrh")
    os.system(f"pwd")
    return 'Just print me'
lambda_handler()
