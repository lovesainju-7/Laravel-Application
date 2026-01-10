# Laravel Docker Application

A Laravel application containerized with Docker, Nginx, and MySQL.


## Project Structure
```
.
├── .docker/
│   └── nginx/
│       └── default.conf    # Nginx configuration
├── Dockerfile              # PHP-FPM container setup
├── docker-compose.yml      # Multi-container orchestration
└── README.md              # This file
```

## Setup Instructions

### 1. Clone the Repository
```bash
git clone "https://github.com/lovesainju-7/Laravel-Application.git"
cd Laravel-Application
```


### 2. Update .env File
If .env is missing:
```bash
cp .env.example .env
```

Edit `.env` and configure the database credentials:
```env
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=secret
```

### 3. Install Dependencies (needed)
```bash
docker-compose exec app composer install
```

### 4. Generate Application Key
```bash
docker-compose exec app php artisan key:generate
```

### 5. Fix MySQL Permissions (IMPORTANT!)
```bash
# Connect to MySQL
docker-compose exec db mysql -u root -proot
```
# Inside MySQL, run:

## [ Method 1: If you’re using a MacBook ]
```bash
GRANT ALL PRIVILEGES ON laravel.* TO 'laravel'@'%' IDENTIFIED BY 'secret';
FLUSH PRIVILEGES;
EXIT;
```
## [ Method 2: If you’re on Windows ]
```bash
GRANT ALL PRIVILEGES ON laravel.* TO 'laravel'@'%' IDENTIFIED BY 'secret';
FLUSH PRIVILEGES;
EXIT;
```
### 6. Run Database Migrations
```bash
docker-compose exec app php artisan migrate
```

Open your browser and visit: **http://localhost:8080**

### 8. Build and Start Containers
```bash
# Build and start all containers
docker-compose up --build -d

# Wait 10-20 seconds for MySQL to initialize
```
Then in bash write:
```bash
#check the present state in compose
docker-compose ps
```
You should see something like:
```bash
NAME            IMAGE                 COMMAND                  SERVICE   CREATED          STATUS          PORTS
laravel-app     laravel-application   "docker-php-entrypoi…"   app       15 seconds ago   Up 14 seconds   9000/tcp
laravel-mysql   mysql:8.0             "docker-entrypoint.s…"   db        15 seconds ago   Up 14 seconds   0.0.0.0:3306->3306/tcp, [::]:3306->3306/tcp
laravel-nginx   nginx:alpine          "/docker-entrypoint.…"   nginx     15 seconds ago   Up 14 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp
```
### 9. Access the Application
Open your browser and visit: **http://localhost:8080**
Open your browser and visit: **http://localhost:8080/user**
