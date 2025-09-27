# GaryOcean C9 IDE Deployment Guide

## Overview
This guide helps deploy your personalized C9 IDE on Railway with PostgreSQL database connectivity.

## Pre-deployment Setup

### 1. Railway Project Setup
1. Fork/clone this repository to your GitHub account
2. Connect your GitHub repository to Railway
3. Create a new Railway project from this repository

### 2. Environment Variables
In your Railway project, set the following environment variables:

#### Required Variables:
- `C9SDK_PASSWORD`: Set to "GaryOcean428" (or your preferred password)

#### Database Variables (automatically set by Railway Postgres service):
- `DATABASE_URL`: Automatically provided by Railway Postgres service
- Alternatively, you can set individual variables:
  - `POSTGRES_HOST`
  - `POSTGRES_USER` 
  - `POSTGRES_PASSWORD`
  - `POSTGRES_DATABASE`
  - `POSTGRES_PORT` (defaults to 5432)

### 3. Add Postgres Service
1. In Railway dashboard, click "Add Service"
2. Select "PostgreSQL" 
3. This will automatically create the Postgres-8xv service
4. The `DATABASE_URL` will be automatically injected into your C9 IDE container

## Deployment Steps

### 1. Deploy to Railway
1. Push your code to GitHub
2. Railway will automatically build using `Dockerfile.railway`
3. The service will be available on Railway's provided domain

### 2. Access Your C9 IDE
1. Open the Railway-provided URL in your browser
2. Login with:
   - **Username**: GaryOcean
   - **Password**: GaryOcean428 (or your custom password)

### 3. Test Database Connection
1. Open the terminal in C9 IDE
2. You should see a welcome message with database status
3. Test the connection using: `db` or `dbconnect`
4. Run SQL queries: `db -c "SELECT version();"`

## Features

### Automatic Database Setup
- PostgreSQL client tools are pre-installed
- Connection aliases (`db`, `dbconnect`) are automatically created  
- Connection status is displayed in welcome message
- Environment variables are auto-detected and configured

### Development Environment
- Full C9 IDE experience with file manager, editor, and terminal
- Node.js, Python, Ruby development support
- Git integration
- nginx reverse proxy for web applications

### Security
- Basic authentication protects your IDE
- Personalized username (GaryOcean) in authentication
- Environment variables are securely injected

## Troubleshooting

### Database Connection Issues
1. Verify Railway Postgres service is running
2. Check that `DATABASE_URL` is set in environment variables  
3. Test connection manually: `psql $DATABASE_URL`

### Login Issues
1. Verify `C9SDK_PASSWORD` environment variable is set
2. Clear browser cache and try again
3. Check Railway service logs for authentication errors

### Port Issues
- C9 IDE runs on port 3399 internally
- Railway exposes this via port 8080
- Ensure Railway service is listening on port 8080

## Support
If you encounter issues, check the Railway service logs and verify all environment variables are properly set.