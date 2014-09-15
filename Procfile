redis: redis-server
web: bundle exec puma -t ${PUMA_MIN_THREADS:-8}:${PUMA_MAX_THREADS:-12} -w ${PUMA_WORKERS:-2} -p $PORT -e ${RACK_ENV:-development}
sidekiq: bin/sidekiq -c 2 -q carrierwave -q default
