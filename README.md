# pgr301_devops_infrastructure

## How to setup project from scratch:
1. Create new project
2. Enable billing for the project(!)
3. Enable cloud storage
4. Enable Google cOntainer Registry API
5. Enable cloud run
6. We're good to go, but lacking a service accoaunt for terraform to create the infrastructure
7. Create the service account with least possible priveledges required (which in this case is Artifact Registry Service Admin, Cloud Run Service Agent, )



Todo: Create a new service account per project.