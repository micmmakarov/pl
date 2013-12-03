window.YTb ||= {}
YTb.App = angular.module('YTapp', [])
App = YTb.App

$(document).on 'page:load', ->
  angular.bootstrap($("html"), ['YTapp'])
  YTb.setImages()
  if YTb.youtubeReady == true
    YTb.getYoutube()
  #YTb.getYoutube()

$ ->
  $(document).trigger "page:load"

YTb.getUrlParams = ->
  prmstr = window.location.search.substr(1)
  prmarr = prmstr.split ("&")
  params = {}
  i = 0
  while i < prmarr.length
    tmparr = prmarr[i].split("=")
    params[tmparr[0]] = tmparr[1]
    i++
  YTb.params = params

# init
YTb.getUrlParams()

# 2. This code loads the IFrame Player API code asynchronously.
tag = document.createElement("script")
tag.src = "https://www.youtube.com/iframe_api"
firstScriptTag = document.getElementsByTagName("script")[0]
firstScriptTag.parentNode.insertBefore tag, firstScriptTag
YTb.getYoutube = ->
  YTb.player = new YT.Player("player",
    #videoId: "M7lc1UVf-VE"
    playerVars: {rel: 0, modestbranding: 1, showinfo: 0}
    events:
      onReady: onPlayerReady
      onStateChange: onPlayerStateChange
  )
  # controls: 0,

window.onYouTubeIframeAPIReady = ->
  YTb.youtubeReady = true
  YTb.getYoutube()

onPlayerReady = (event) ->
  #event.target.playVideo()
  player = YTb.player
  #setInterval YTb.updatePlayerInfo, 250
  YTb.whenPlayerReady()

YTb.whenPlayerReady = ->
  true

# 5. The API calls this function when the player's state changes.
#    The function indicates that when playing a video (state=1),
#    the player should play for six seconds and then stop.
onPlayerStateChange = (event) ->
  true
  #if event.data is YT.PlayerState.PLAYING and not done
  #  done = true


App.controller "MyVideosCtrl", ["$scope", ($scope) ->

  YTb.updatePlayerInfo = ->
    #$scope.$apply ->
      #$scope.progress = YTb.player.getCurrentTime()

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

YTb.setImages = ->
  images = $(".video .image")
  angular.forEach(images, (i) ->
    image = $(i)
    w = image.width()
    if image.parent().hasClass "big"
      formula = w / 3 * 2.1
    else
      formula = w / 3 * 1.8
    image.height(formula)
  )

YTb.setPlayer = ->
  player = $(".player")
  player.css
    left: ($(window).width() - player.outerWidth()) / 2
    top: ($(window).height() - player.outerHeight()) / 2

$ ->
  $(window).resize ->
    YTb.setImages()
    YTb.setPlayer()

App.controller "ProfileCtrl", ["$scope", ($scope) ->
  #$http.post('/api/getyoutube', data).success(->
  #)
  $scope.getVideo = ->
    $("#file").trigger("click")

]

App.controller "VideoListCtrl", ["$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->

  $ ->
    if YTb.params.play
      YTb.whenPlayerReady = ->
        $scope.$apply ->
          $scope.play(_.findWhere($scope.videos, {id: parseInt(YTb.params.play)}))

  $scope.getData = (data) ->
    $scope.videos = data

  $scope.play = (video) ->
    console.log "playing ", video
    YTb.player.loadVideoById(video.youtube_id)
    $rootScope.currentVideo = video
    YTb.player.playVideo()
    YTb.setPlayer()
    window.history.replaceState( {} , 'foo', "/?play=#{video.id}" )
    path = location.href
    params = {}
    params.width = 250;
    params.id = 'facebook-like'
    window.iframeGenerator.facebook("comedymichael", "comedymichael", path, params)
    window.iframeGenerator.twitter("michaelmakarov")

]


App.controller "GlobalCtrl", ["$scope", "$rootScope", "$http", ($scope, $rootScope, $http) ->
  $scope.stop = ->
    YTb.player.stopVideo()
    $rootScope.currentVideo = null
    window.history.replaceState( {} , 'foo', "/" )
    $scope.burgerOpened = false

  $scope.vote = (v) ->
    console.log v.voted
    data = {id: v.id}
    $http
      method: 'POST'
      url: "/api/votes/"
      data: data
    .success( (result) ->
      if result.destroyed
        v.votes_count = v.votes_count - 1
        v.voted = false
      else
        v.votes_count = v.votes_count + 1
        v.voted = true
    )

]