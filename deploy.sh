#!/bin/bash
openssl aes-256-cbc -K $encrypted_ed741c330351_key -iv $encrypted_ed741c330351_iv -in mgen_github_deploy_key.enc -out mgen_github_deploy_key -d
chmod 0400 mgen_github_deploy_key

helm init --client-only
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

helm dependency update malariagen

GIT_SSH_COMMAND="ssh -i ${PWD}/mgen_github_deploy_key" chartpress --commit-range ${TRAVIS_COMMIT_RANGE} --publish-chart

