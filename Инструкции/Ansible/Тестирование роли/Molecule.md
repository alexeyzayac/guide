
## Установка 
```bash
#Установите pipx
sudo apt update && sudo apt install pipx
pipx ensurepath
source ~/.bashrc

#Установите molecule через pipx
pipx install molecule --force
pipx inject molecule  
pipx inject molecule_docker --force #Для Docker
pipx inject molecule_podman --force #Для Podman

#Проверьте, какая версия molecule вызывается
which molecule
molecule --version
```
---
## Показать матрицу теста
```bash
molecule matrix test
```

| Стадия        | Назначение                                                                     |
| ------------- | ------------------------------------------------------------------------------ |
| `destroy`     | Удалить все тестовые экземпляры.                                               |
| `create`      | Создать тестовые экземпляры (контейнеры/VMs).                                  |
| `converge`    | Применить тестируемую Ansible‑конфигурацию.                                    |
| `verify`      | Выполнить проверки (assertions) состояния системы.                             |
| `dependency`  | Установить зависимости роли (galaxy roles, collections).                       |
| `syntax`      | Проверить синтаксис Ansible playbook'ов.                                       |
| `prepare`     | Дополнительная подготовка окружения перед `converge`.                          |
| `idempotence` | Повторно запустить `converge`, убедиться, что изменений нет.                   |
| `side_effect` | Внести изменения (сломать состояние) и повторно выполнить `converge`/`verify`. |
| `cleanup`     | Откатить изменения после `converge` (редко используется).                      |

> **Примечание:** Если какая‑то стадия не нужна, лучше убрать её из `test_sequence` в `molecule.yml`, а не оставлять с пометкой `Missing playbook`.

```yaml
scenario:
  test_sequence:
	- destroy
	- create
	- converge
	- verify
	- destroy
```
---