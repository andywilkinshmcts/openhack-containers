echo "deploying poi"
kubectl apply -f ./aks/Team4Deployment_poi.yaml -n api

echo "deploying trips"
kubectl apply -f ./aks/Team4Deployment_trips.yaml -n api

echo "deploying User-java"
kubectl apply -f ./aks/Team4Deployment_user-java.yaml -n api

echo "deploying user-profile"
kubectl apply -f ./aks/Team4Deployment_user.yaml -n api

echo "deploying tripviewer"
kubectl apply -f ./aks/Team4Deployment_tripviewer.yaml -n web

echo "deploying trip servicer"
kubectl apply -f ./aks/Team4TripsService.yaml  -n api

echo "deploying userprofile service"
kubectl apply -f ./aks/Team4UserProfileService.yaml  -n api

echo "deploying tripviewer service"
kubectl apply -f ./aks/Team4TripViewerService.yaml  -n web