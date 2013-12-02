window.iframeGenerator =
  iframeHeader:
    id: 'iframeHeader'
    width: 450
    allowTransparency: 'true'
    scrolling: 'no'
    frameBorder: 0
    align: 'center'
    valign: 'top'
    marginwidth: 0
    marginheight: 0
    hspace: 0
    vspace: 0
  toParams: (address) ->
    if (not address.match "http://")and(not address.match "https://")
      address = "http://#{address}"
    a = {}
    a[address] = 0
    p = $.param(a)
    p[0..(p.length-3)]
  facebook: (userpage, fanpage, address, args...) ->
    console.log args, args[0]
    params = args[0] if args
    params ?= {}
    params.id ?= 'facebook-like'
    params.width ?= 450
    params.height ?= 65
    console.log params
    document.getElementById(params.id).innerHTML = ""
    iframeHeaderCell = document.getElementById(params.id)
    console.log "ADDRESS!!!", @toParams(address)
    if address
      dynamicURL = "//www.facebook.com/plugins/like.php?href=#{@toParams(address)}&amp;send=false&amp;layout=standard&amp;width=#{params.width}&amp;show_faces=true&amp;font&amp;colorscheme=dark&amp;action=like&amp;height=#{params.height}&amp;appId=222424071230782"
    #if userpage
    #  console.log @toParams(userpage)
    #  dynamicURL = "//www.facebook.com/plugins/follow.php?href=#{@toParams(userpage)}&amp;layout=standard&amp;show_faces=true&amp;colorscheme=dark&amp;font&amp;width=450&amp;appId=131712900355782"
    iframeHeader = $.extend(document.createElement('IFRAME'), @iframeHeader)
    iframeHeader.height = params.height
    iframeHeader.width = params.width
    iframeHeader.src = dynamicURL
    iframeHeader.style = "border:none; overflow:hidden; width:#{params.width}px; height:80px;"
    iframeHeaderCell.appendChild(iframeHeader)
  twitter: (username) ->
    document.getElementById('twitter-follow').innerHTML = ""
    iframeHeaderCell = document.getElementById('twitter-follow')
    dynamicURL = "//platform.twitter.com/widgets/tweet_button.html?text=Awesome joke dudes!"
    iframeHeader = $.extend(document.createElement('IFRAME'), @iframeHeader)
    iframeHeader.src = dynamicURL
    iframeHeader.height = 20
    iframeHeader.style = "width:300px; height:20px;"
    iframeHeaderCell.appendChild(iframeHeader)