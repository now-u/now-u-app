generate:
	curl http://localhost:8000/api/schema/ --output openapi-schema.yml
	rm -rf causeApi
	openapi-generator-cli generate -i openapi-schema.yml -g dart-dio -c open-generator-config.yml --enable-post-process-file -o causeApi
	cd causeApi && flutter pub get
	cd causeApi && flutter pub run build_runner build
