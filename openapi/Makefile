generate-local:
	curl http://localhost:8000/api/schema/ --output openapi-schema.yml
	rm -rf causeApi
	openapi-generator-cli generate -i openapi-schema.yml -g dart-dio -c open-generator-config.yml --enable-post-process-file -o causeApi
	cd causeApi && flutter pub get
	cd causeApi && flutter pub run build_runner build

generate-prod:
	curl https://causes.dev.apiv2.now-u.com/api/schema/ --output openapi-schema.yml
	rm -rf causeApi
	openapi-generator-cli generate -i openapi-schema.yml -g dart-dio -c open-generator-config.yml --enable-post-process-file -o causeApi
	cd causeApi && flutter pub get
	cd causeApi && flutter pub run build_runner build

generate-prod-docker:
	curl https://causes.dev.apiv2.now-u.com/api/schema/ --output openapi-schema.yml
	rm -rf causeApi
	docker run --rm \
  		-v ${PWD}:/local openapitools/openapi-generator-cli generate \
  			-i /local/openapi-schema.yml \
  			-g dart-dio \
			-c /local/open-generator-config.yml \
			--enable-post-process-file \
  			-o /local/causeApi
	sudo chown -R ${USER} causeApi
	cd causeApi && flutter pub get
	cd causeApi && flutter pub run build_runner build
