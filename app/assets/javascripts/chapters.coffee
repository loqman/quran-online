# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  String.prototype.toFarsi = ->
    $this = this
    farsiNumbers = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹']
    matches = $this.match /[0-9]/g
    str = $this
    if matches
      matches.forEach (m) ->
        str = str.replace m, farsiNumbers[parseInt(m)]
    str.toLowerCase()

  String.prototype.toLatin = ->
    $this = this
    latinNumbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
    farsiNumbers = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹']
    matches = $this.match /[\u06F0-\u06F9]/g
    str = $this
    if matches
      matches.forEach (m) ->
        str = str.replace m, latinNumbers[farsiNumbers.indexOf(m)]
    str.toLowerCase()

  isAutoplay = ->
    if parseInt(window.localStorage.getItem('autoplay')) == 1
      return true
    false

  setVerseNumber = (verse) ->
    currentVerse = "#{verse}".toFarsi()
    value = "آیه #{currentVerse}  از  #{window.totalVerses}"
    $("#verse_number").val value.toFarsi()
    cVerse = $("a[data-verse='#{verse}']")
    cVerse.addClass('current-verse')
    scrollTop = $(document).scrollTop() + 70
    viewPortHeight = $(window).innerHeight() - 100
    verseTopOffset = cVerse.offset().top
    verseTopOffsetWithHeight = verseTopOffset + cVerse.height()
    if parseInt(window.localStorage.getItem('show_translation')) == 1
      verseTopOffsetWithHeight += cVerse.find('.translation').height()
    if !(verseTopOffset >= scrollTop and verseTopOffsetWithHeight < (viewPortHeight + scrollTop))
      $(document).scrollTo { left: 0, top: verseTopOffset - 75 },
        { duration: 200 }

  selectVerse = (verse) ->
    if parseInt(window.localStorage.getItem(window.currentChapterKey)) != parseInt(verse)
      $(".current-verse").removeClass('current-verse')
      window.currentVerse = $("li[data-verse='#{verse}']")
      window.localStorage.setItem(window.currentChapterKey, verse)
      $(window.audioPlayer).attr 'src', window.currentVerse.data('audio')
      setVerseNumber(verse)
      if isAutoplay()
        playVerse()

  $('#verse_number').focus (e) ->
    $('#verse_number').val(window.localStorage.getItem(window.currentChapterKey).toFarsi())

  $('#verse_number').blur (e) ->
    setVerseNumber(window.localStorage.getItem(window.currentChapterKey))

  $('#verse_change').submit (e) ->
    e.preventDefault()
    verse_number = $('#verse_number').val().toLatin()
    if parseInt(verse_number) > 0 and parseInt(verse_number) <= parseInt(window.totalVerses)
      selectVerse verse_number
    $('#verse_number').trigger 'blur'
    false

  $('#show_translation').click (e) ->
    e.preventDefault()
    getTopViewableVerse()
    $('.translation').toggleClass('hidden')
    $('.translation-link').toggleClass('active')
    window.localStorage.setItem('show_translation', window.localStorage.getItem('show_translation') * -1)
    if window.playing
      window.verseTop = window.currentVerse.data('verse')
    else
      window.verseTop = window.topViewableVerse
    setTimeout ->
      top = $("a[data-verse='#{window.verseTop}']").offset().top - 75
      $(document).scrollTo { left: 0, top: top },
        { duration: 200 }
    , 200
    false

  $('#autoplay').click (e) ->
    e.preventDefault()
    $('.autoplay-link').toggleClass('active')
    window.localStorage.setItem('autoplay', window.localStorage.getItem('autoplay') * -1)
    if !window.playing && isAutoplay()
      playVerse()
    false

  if window.localStorage.getItem('show_translation') == null
    window.localStorage.setItem('show_translation', -1)

  if window.localStorage.getItem('autoplay') == null
    window.localStorage.setItem('autoplay', 1)

  if parseInt(window.localStorage.getItem('show_translation')) == 1
    $('.translation').removeClass('hidden')
    $('.translation-link').addClass('active')

  if parseInt(window.localStorage.getItem('autoplay')) == 1
    $('.autoplay-link').addClass('active')

  window.audioPlayer = document.getElementsByTagName('audio')[0]
  window.totalVerses = $('.chapter').data('verse')
  window.currentChapter = $('.chapter').find('a').first().data 'chapter'
  window.currentChapterKey = "chapter_#{window.currentChapter}_current_verse"
  if window.localStorage.getItem(window.currentChapterKey) == null
    window.localStorage.setItem(window.currentChapterKey, 1)
  window.currentVerse = $(".recites li[data-verse='#{window.localStorage.getItem(window.currentChapterKey)}']")
  $("a[data-verse='#{window.localStorage.getItem(window.currentChapterKey)}']").addClass('current-verse')
  setVerseNumber(window.localStorage.getItem(window.currentChapterKey))
  window.playing = false

  $('.chapter a').click ->
    verse = $(this).data 'verse'
    selectVerse(verse)

  $(window.audioPlayer).attr 'src', window.currentVerse.data('audio')
  $(window.audioPlayer).on 'pause', ->
    window.playing = false
    if !window.playing
      $('.play-verse').removeClass 'active'
      $('.pause-verse').addClass 'active'
    if window.audioPlayer.ended && isAutoplay()
      playNextVerse()

  $('.play-verse').click ->
    playVerse()
    false

  $('.pause-verse').click ->
    window.audioPlayer.pause()
    false

  playNextVerse = ->
    verse = window.currentVerse.data 'verse'
    $("a[data-verse='#{verse}']").removeClass('current-verse')
    next = window.currentVerse.next()
    if next.data('type') == 'translation' and true # parseInt(window.localStorage.getItem('show_translation')) == -1
      next = next.next()
    if next.length == 0
      window.currentVerse = $('.recites li').first()
      window.localStorage.setItem(window.currentChapterKey, 1)
      $(window.audioPlayer).attr 'src', window.currentVerse.data('audio')
    else
      window.currentVerse = next
      window.localStorage.setItem(window.currentChapterKey, verse + 1)
      $(window.audioPlayer).attr 'src', window.currentVerse.data('audio')
      playVerse()

  playVerse = ->
    window.playing = true
    verse = window.currentVerse.data 'verse'
    if window.playing
      $('.pause-verse').removeClass('active')
      $('.play-verse').addClass('active')
      if window.currentVerse.data('type') == 'translation'
        $("a[data-verse='#{verse}']").find('.translation').addClass('active')
      else
        $("a[data-verse='#{verse}']").find('.translation').removeClass('active')
    setVerseNumber(verse)
    window.audioPlayer.play()

  calculateTheOffsetOfVerses = ->
    versesLocation = new Array()
    $("a[data-chapter='#{window.currentChapter}']").each (verse) ->
      offset = $("a[data-verse='#{verse}']").offset()
      versesLocation[verse - 1] = offset
    window.versesLocation = versesLocation

  getTopViewableVerse = ->
    calculateTheOffsetOfVerses()
    scrollTop = $(document).scrollTop() + 70
    a = [window.versesLocation.length..1]
    a.forEach (v) ->
      if scrollTop <= window.versesLocation[v - 1].top
        window.topViewableVerse = v
