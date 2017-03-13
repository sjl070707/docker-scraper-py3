FROM markadams/chromium-xvfb

RUN apt-get update && apt-get install -y \
    python3 python3-pip libgconf-2-4 python3-pandas

RUN apt-get install -y curl unzip wget bzip2

RUN apt-get install -y libgconf-2-4 python-dev \
    libxml2-dev libxslt1-dev zlib1g-dev build-essential chrpath libssl-dev libxft-dev \
    libfreetype6 libfreetype6-dev libfontconfig1 libfontconfig1-dev

ENV CHROMEDRIVER_VERSION 2.14

RUN curl -SLO "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" \
  && unzip "chromedriver_linux64.zip" -d /usr/local/bin \
  && rm "chromedriver_linux64.zip"

RUN cd ~

#Start configuring phantomJS
RUN cd /tmp && \
  export PHANTOM_JS="phantomjs-2.1.1-linux-x86_64" && \
  wget https://github.com/Medium/phantomjs/releases/download/v2.1.1/$PHANTOM_JS.tar.bz2 && \
  tar xvjf $PHANTOM_JS.tar.bz2 && \
  mv $PHANTOM_JS /usr/local/share && \
  ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin && \
  rm -rf /tmp/*
#End configuring phantomJS


WORKDIR /app

#install python packages
ADD requirements.txt .

RUN pip3 install -r requirements.txt

# ADD . .
#
# CMD ["python3","ypLastStage.py"]
