## This project implements the Whisper AI models in an easily accessible and simple to use containerized Web App.
## No need to mess with config files and pip dependencies, everything comes packages in a single docker container ready to be used. 

## Check out the project on Docker Hub - [Docker Hub](https://hub.docker.com/repository/docker/cbcb00/audio2txt/general)


# Quick Start

The container runs on port 5000, launch and run it using the below command.

```
docker run -d --name=audio2txt -p 5000:5000 cbcb00/audio2txt
```
### Browse to http://your-host-ip:5000 to access the web UI

# Building it yourself

You can also build the container locally. Just clone this repository
```
git clone https://github.com/cbcb00/audio2txt.git
```

Then change into the directory
```
cd audio2txt
```

Build the container
```
docker build -t audio2txt .
```

Finally once the container is build you can launch it using the command 
```
docker run -d --name=audio2txt -p 5000:5000 audio2txt
```

# Additional Notes

## The container runs the base model of Whisper by default, if you want to change it, follow the instructions below. (For future builds I am hoping to incorporate this into the docker run command)

1. Once the container is running, enter it
   ```
   docker exec -it audio2txt bash
   ```
2. Look for the **text.py** file and open it (You can install and use an editor of your choice I am using nano)
   ```
   nano text.py
   ```
3. You should see the below line
   ```
   # Load the Whisper model
   model = whisper.load_model("base")
   ```
4. Change it to anything you like based on the below table (Warning: Higher models require a moderately powerful GPU or CPU else it will take forever to load)

| SIze | Parameters | English-only model | Multilingual Model  | Requied VRAM | 
| ------| | ------------------- | ------------------------------ | ----------------------------- | ------------------------ |
| tiny |  39 M            |  tiny.en                      | tiny                           | ~ 1 GB                |
| base | 	74 M  |	base.en  |  base | ~1 GB |  ~16x | 
| small |	244 M |	small.en |	small |	~2 GB |	~6x |
| medium |	769 M |	medium.en |	medium |	~5 GB |	~2x |
| large  |	1550 M  | N/A  | large | ~10 GB  | 1x |

5. For example if you want to run the medium model your code should look like this.
   ```
   # Load the Whisper model
   model = whisper.load_model("medium")
   ```
6. Just restart the container and upload your audio and it will automatically pull the new model.

# Future Plans
- Plans to make the model change accessible during the run command itself to prevent additional work when changing models
- Currently the app is running on the development server, soon I will be moving it to a WSGI server for proper production use
- Beautify the web app further since right now its quite barebones but it does the job!

# Credits
Special credits go to the OpenAI Whisper project which has made this project possible! Check them out at - [Whisper Project](https://github.com/openai/whisper)
