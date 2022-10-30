install:
	sh ./install.sh

migrate:
	docker-compose exec -T api-php php bin/console doctrine:migrations:diff --no-interaction
	docker-compose exec -T api-php php bin/console doctrine:migrations:migrate --no-interaction

diff_migrations:
	docker-compose exec -T api-php php bin/console doctrine:migrations:diff --no-interaction

migrations:
	docker-compose exec -T api-php php bin/console doctrine:migrations:migrate --no-interaction

composer_install:
	COMPOSER_ALLOW_SUPERUSER=1 docker-compose exec -T api-php composer self-update
	COMPOSER_ALLOW_SUPERUSER=1 docker-compose exec -T api-php composer install --no-interaction --classmap-authoritative --optimize-autoloader

composer_update:
	COMPOSER_ALLOW_SUPERUSER=1 docker-compose exec -T api-php composer self-update
	COMPOSER_ALLOW_SUPERUSER=1 docker-compose exec -T api-php composer update --no-interaction --classmap-authoritative --optimize-autoloader

build_dev:
	docker-compose -f docker-compose.yaml -f docker-compose-dev.yaml build

start_dev:
	docker-compose -f docker-compose.yaml -f docker-compose-dev.yaml up -d

stop:
	docker-compose down

execphp:
	docker-compose exec api-php bash

execdb:
	docker-compose exec api-mysql bash
