#!/bin/bash
composer i
php artisan migrate
php artisan serve --host 0.0.0.0
