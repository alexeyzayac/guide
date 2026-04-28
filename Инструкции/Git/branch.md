```bash
# 1. Переименовать локальную ветку
git branch -m 15_05_docker_swarm_cluster_orchestration 15.05_docker_swarm_cluster_orchestration

# 2. Удалить старую ветку на origin (если она там есть)
git push origin --delete 15_05_docker_swarm_cluster_orchestration

# 3. Запушить новую ветку и установить upstream
git push origin -u 15.05_docker_swarm_cluster_orchestration
```