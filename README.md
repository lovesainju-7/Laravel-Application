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

Edit `.env` and configure the database credentials:
```env
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=secret
```

### 3. Build and Start Containers
```bash
# Build and start all containers
docker-compose up --build -d

# Wait 10-20 seconds for MySQL to initialize
```

### 5. Install Dependencies (if needed)
```bash
docker-compose exec app composer install
```

### 6. Generate Application Key
```bash
docker-compose exec app php artisan key:generate
```

### 7. Fix MySQL Permissions (IMPORTANT!)
```bash
# Connect to MySQL
docker-compose exec db mysql -u root -prootpassword

# Inside MySQL, run:
GRANT ALL PRIVILEGES ON laravel.* TO 'laravel'@'%' IDENTIFIED BY 'secret';
FLUSH PRIVILEGES;
EXIT;
```

### 8. Run Database Migrations
```bash
docker-compose exec app php artisan migrate
```

### 9. Access the Application

Open your browser and visit: **http://localhost:8080**


