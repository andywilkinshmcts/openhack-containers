echo "deploying poi"
kubectl apply -f ./aks/Team4Deployment_poi.yaml

echo "deploying trips"
kubectl apply -f ./aks/Team4Deployment_trips.yaml

echo "deploying User-java"
kubectl apply -f ./aks/Team4Deployment_user-java.yaml

echo "deploying user-profile"
kubectl apply -f ./aks/Team4Deployment_user.yaml

echo "deploying tripviewer"
kubectl apply -f ./aks/Team4Deployment_tripviewer.yaml

echo "deploying trip servicer"
kubectl apply -f ./aks/Team4TripsService.yaml

echo "deploying userprofile service"
kubectl apply -f ./aks/Team4UserProfileService.yaml