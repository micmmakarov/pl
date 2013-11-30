window.YTb ||= {}
YTb.App = angular.module('YTapp', [])
App = YTb.App

# 2. This code loads the IFrame Player API code asynchronously.
tag = document.createElement("script")
tag.src = "https://www.youtube.com/iframe_api"
firstScriptTag = document.getElementsByTagName("script")[0]
firstScriptTag.parentNode.insertBefore tag, firstScriptTag
window.onYouTubeIframeAPIReady = ->
  YTb.player = new YT.Player("player",
    height: "390"
    width: "640"
    videoId: "M7lc1UVf-VE"
    playerVars: {controls: 0}
    events:
      onReady: onPlayerReady
      onStateChange: onPlayerStateChange
  )

onPlayerReady = (event) ->
  event.target.playVideo()
  player = YTb.player
  setInterval YTb.updatePlayerInfo, 250

# 5. The API calls this function when the player's state changes.
#    The function indicates that when playing a video (state=1),
#    the player should play for six seconds and then stop.
onPlayerStateChange = (event) ->
  if event.data is YT.PlayerState.PLAYING and not done
    done = true
stopVideo = ->
  player.stopVideo()
done = false

App.controller "MyVideosCtrl", ["$scope", ($scope) ->

  YTb.updatePlayerInfo = ->
    $scope.$apply ->
      $scope.progress = YTb.player.getCurrentTime()

  $scope.getData = (data) ->
    $scope.videos = data.videos

  $scope.play = ->
    YTb.player.playVideo()

  $scope.stop = ->
    YTb.player.stopVideo()

  $scope.pause = ->
    YTb.player.pauseVideo()

  $scope.load = (id) ->
    YTb.player.loadVideoById(id)

]

App.controller "ProfileCtrl", ["$scope", ($scope) ->
  $http.post('/api/getyoutube', data).success(->
  )
]

App.controller "VideoListCtrl", ["$scope", "$http", ($scope, $http) ->

  $scope.getData = (data) ->
    $scope.videos = data

  $scope.vote = (v) ->
    if v.voted?
      data = {id: v.id}
      $http
        method: 'POST'
        url: "/api/votes/"
        data: data
      .success( ->
        console.log "YES!"
      )
    else
      $http({method: 'DELETE', url: "/api/votes/#{v.id}"}).success( ->
        console.log "YES!"
      )


]