


function GeoCoreController($scope, $http) {

    var map; 
    $scope.config = [];
    

    $http({ method: 'GET', url: 'home/GetSiteSettings' }).success(function(data) {

        $scope.siteName = data[0].SiteName;
        $scope.zoom = data[0].ZoomLevel;
        $scope.startLatitude = data[0].StartLatitude;
        $scope.startLongitude = data[0].StartLongitude;
        $scope.baseMap = data[0].BaseMap;
        
        $scope.loadMap($scope.config, $scope.zoom, $scope.startLatitude, $scope.startLongitude, $scope.baseMap);

    }).error(function(data, status, headers, config) {
        alert('Something went terribly wrong!');
    });

    


    $scope.loadMap = function (config, zoom, startLatitude, startLongitude, baseMap) {

        switch (baseMap) {
            case 'Open Street Map':
                base = L.tileLayer("http://{s}.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.png", {
                    maxZoom: 19,
                    subdomains: ["otile1", "otile2", "otile3", "otile4"],
                    attribution: 'Tiles courtesy of <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png">. Map data (c) <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> contributors, CC-BY-SA.'
                });
                break;
            case 'Grey Canvas':
                base = L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
                    maxZoom: 18,
                    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
                        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
                        'Imagery © <a href="http://mapbox.com">Mapbox</a>',
                    id: 'examples.map-20v6611k'
                });
                break;
        }



        map = L.map("map", {
            zoom: zoom,
            center: new L.LatLng(startLatitude, startLongitude),
            'zoomControl': false,
            layers: [base]
        });

        map.addControl(L.control.zoom({ position: 'bottomleft' }));


    };




   
}


