FROM nginx
EXPOSE 80
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \ 
    CMD curl -fs http://localhost/ || exit 1