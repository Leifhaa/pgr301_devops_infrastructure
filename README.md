# pgr301_devops_infrastructure

## How to setup project from scratch:
1. Create new project
2. Enable billing for the project(!)
3. Enable cloud storage
4. Enable Google cOntainer Registry API
5. Enable cloud run
6. We're good to go, but lacking a service accoaunt for terraform to create the infrastructure
7. Create the service account with least possible priveledges required (which in this case is Artifact Registry Service Admin, Cloud Run Service Agent, )
8. Add this service account as terraform_keyfile.json.enc
9. Create .tf files for setting up the infrastructure.
10. Setup .travis.yml for deploying the infrastructure.


Neccesairy enviroment variables for building this project with terraform:
LOGZ_TOKEN = Token for pushing logs to logz.io
LOGZ_URL = URL for pushing logs to logz.io
STATUSCAKE_APIKEY = The API key from StatusCake
AWS_ACCESS_KEY_ID = AWS account ID for setup of AWS resoruces
AWS_SECRET_ACCESS_KEY = AWS account access key for setting up AWS resources




Todo: Create a new service account per project.