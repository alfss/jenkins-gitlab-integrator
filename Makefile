VERSION := $(shell cat server/main.py | grep -i "SERVER_VERSION =" | cut -d'=' -f2 | tr -d '" \n')

dev_prepare:
	pip install -r requirements.txt
	docker-compose -p dev -f docker-compose.yml up -d mysql

dev_server:
	docker-compose -p dev -f docker-compose.yml run --rm server migrate
	docker-compose -p dev -f docker-compose.yml up -d server

build_docker:
	find . -name __pycache__ -execdir rm -r {} +
	find . -name '*.pyc' -delete
	docker build -f Dockerfile  -t alfss/jenkins-gitlab-integrator:latest .

build_docker_release:
	find . -name __pycache__ -execdir rm -r {} +
	find . -name '*.pyc' -delete
	docker build -f Dockerfile  -t alfss/jenkins-gitlab-integrator:latest .
	docker build -f Dockerfile  -t alfss/jenkins-gitlab-integrator:${VERSION} .

push_docker_release:
	docker push alfss/jenkins-gitlab-integrator:latest
	docker push alfss/jenkins-gitlab-integrator:${VERSION}

test:
	docker-compose -p test -f docker-compose.yml rm -fs mysql_test
	docker-compose -p test -f docker-compose.yml up -d mysql_test
	sleep 30
	alembic -n alembic_test -c config/alembic.ini upgrade head
	PYTHONPATH=. py.test -v
	docker-compose -p test -f docker-compose.yml rm -fs mysql_test
