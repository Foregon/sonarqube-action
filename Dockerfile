FROM newtmitch/sonar-scanner:4.0.0-alpine

LABEL "com.github.actions.name"="SonarQube Scan"
LABEL "com.github.actions.description"="Scan your code with SonarQube Scanner to detect bugs, vulnerabilities and code smells in more than 25 programming languages."
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="green"

LABEL version="0.0.1"
LABEL repository="https://github.com/Foregon/sonarqube-action"
LABEL homepage="https://github.com/Foregon/sonarqube-action"
LABEL maintainer="Foregon"

RUN apk add jq
RUN npm config set unsafe-perm true && \
  npm install --silent --save-dev -g typescript@3.5.2 && \
  npm config set unsafe-perm false
ENV NODE_PATH "/usr/lib/node_modules/"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
