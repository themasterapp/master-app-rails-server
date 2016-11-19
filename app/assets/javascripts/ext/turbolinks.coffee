# Monkey patch Turbolinks to render 404 & 500 normally
Turbolinks.HttpRequest.prototype.requestLoaded = ->
  @endRequest =>
    if 200 <= @xhr.status < 300 or @xhr.status = 404 or @xhr.status = 500
      @delegate.requestCompletedWithResponse(@xhr.responseText, @xhr.getResponseHeader("Turbolinks-Location"))
    else
      @failed = true
      @delegate.requestFailedWithStatusCode(@xhr.status, @xhr.responseText)
