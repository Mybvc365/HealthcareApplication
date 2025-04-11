# Use the official NGINX image from Docker Hub
FROM nginx:latest

# Copy the static website files to the NGINX web directory
# Assuming your HTML files are in a folder named 'website'
COPY . /usr/share/nginx/html/

# Expose port 80 to access the website outside the container
EXPOSE 80

# The default command in the NGINX image is already set to run NGINX in the foreground
# No need to add additional command
