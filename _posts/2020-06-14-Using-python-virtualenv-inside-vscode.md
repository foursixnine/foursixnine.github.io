---
layout: post
title: Using python virtualenv inside vscode
categories:
- blog
generated on: 2020-06-14
---
## Quick and dirty

* Install  python3-virtualenvwrapper (via pip or via package manager)
* Export a workon directory: `export WORKON_HOME=/home/foursixnine/Projects/python-virtualenv`
* `source virtualenvwrapper`

```
foursixnine@deimos:~/Projects> source virtualenvwrapper    
virtualenvwrapper.user_scripts creating /home/foursixnine/Projects/python-virtualenv/premkproject
...
virtualenvwrapper.user_scripts creating /home/foursixnine/Projects/python-virtualenv/get_env_details
```

* mkvirtualenv newenv

```bash
foursixnine@deimos:~/Projects> mkvirtualenv newenv
created virtual environment CPython3.8.3.final.0-64 in 115ms
  creator CPython3Posix(dest=/home/foursixnine/Projects/python-virtualenv/newenv, clear=False, global=False)
  seeder FromAppData(download=False, pip=latest, setuptools=latest, wheel=latest, via=copy, app_data_dir=/home/foursixnine/.local/share/virtualenv/seed-app-data/v1.0.1)
  activators BashActivator,CShellActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator
virtualenvwrapper.user_scripts creating /home/foursixnine/Projects/python-virtualenv/newenv/bin/predeactivate
...
virtualenvwrapper.user_scripts creating /home/foursixnine/Projects/python-virtualenv/newenv/bin/get_env_details
```

* By this point, you're already inside `newenv`:

```bash
(newenv) foursixnine@deimos:~/Projects> 
```

* You can create multiple virtual environments and switch among them using `workon $env` so long as you have sourced `virtualenvwrapper` and your `$WORKON_HOME` is properly defined.

## Real business

* Now, if you want to use vscode, remember that you will need to define properly `python.PythonPath` for your workspace/project (I'm new to this, don't hang me in a public square ok?), in this case, my env is called linkedinlearningaiml

```json
{
    "python.pythonPath": "/home/foursixnine/Projects/python-virtualenv/linkedinlearningaiml/bin/python"
}
```

Now your python code will be executed within the context of your virtual environment, so you can get down to serious (or not at all) python development, without screweing up your host or polluting the dependencies and stuff.

PS: Since wanted to be able to run standalone python files, I also needed to change a bit my launch.json (Maybe this is not needed?)

```json
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "cwd": "${fileDirname}"
        }
    ]
}
```

And off you go, how to use python virtualenv inside vscode

*Et voilà, ma chérie!*
![It's alive!](https://media.giphy.com/media/xT5LMDi8H2A1FtLlpC/giphy.gif)
