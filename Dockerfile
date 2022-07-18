FROM nikolaik/python-nodejs:python3.10-nodejs17
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get autoremove --purge
RUN pip3 install --upgrade pip setuptools 
RUN if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi 
RUN if [ ! -e /usr/bin/python ]; then ln -sf /usr/bin/python3 /usr/bin/python; fi 
RUN rm -r /root/.cache
RUN git clone -b master https://github.com/gsweq11/YukkiMusicBot /root/gsweq11
RUN mkdir /root/gsweq11/bin/
WORKDIR /root/gsweq11/
RUN chmod +x /usr/local/bin/*

# YNTKTS LMAO :) 
COPY . /app/
WORKDIR /app/
RUN chmod 777 /app/

# install requirements 
RUN python3 -m pip install -U -r https://raw.githubusercontent.com/gsweq11/YukkiMusicBot/master/requirements.txt
RUN python3 -m pip install --no-cache-dir -r https://raw.githubusercontent.com/TeamKillerX/KillerX-Music/dev/resources/startup/optional-requirements.txt

# final run 
CMD ["bash", "startup.sh"]
