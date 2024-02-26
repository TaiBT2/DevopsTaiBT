FROM devopsfaith/krakend:watch 

# Create app directory
#WORKDIR /opt/app

# Install app dependencies
# Copy package.json and package-lock.json before other files
# Utilise Docker cache to save re-installing dependencies if unchanged
#COPY ./package*.json ./

#RUN npm install --only=dev

#EXPOSE 8080

# Run
CMD [ "run", "--config", "/etc/krakend/krakend.json" ]
