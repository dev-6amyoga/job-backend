FROM linuxserver/ffmpeg AS ffmpeg
FROM node:20

COPY --from=ffmpeg / /

RUN which adduser

RUN adduser user-10038
USER user-10038

WORKDIR /

COPY ./package*.json ./job-backend/

COPY ./*.js ./job-backend/
COPY ./*.json ./job-backend/
COPY ./*.yaml ./job-backend/


COPY ./models/ ./job-backend/models/
COPY ./routes/ ./job-backend/routes/
COPY ./utils/ ./job-backend/utils/
# COPY ./job-backend/*.py ./job-backend/
WORKDIR /job-backend

RUN npm install

EXPOSE 4040

CMD ["node", "server.js"]

