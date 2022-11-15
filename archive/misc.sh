MSYS_NO_PATHCONV=1 az ad sp create-for-rbac --name "myApp" --role contributor \
                        --scopes /subscriptions/06b0c3bb-5055-4ed2-85b6-6fbc77149297/resourceGroups/flask-portfolio-project \
                        --sdk-auth