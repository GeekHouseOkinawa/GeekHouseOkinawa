weights =
  "2012-05-17": 79.8
  "2012-05-18": 79.6
  "2012-05-19": 78.9

date_format = (d) ->
  d = new Date d
  year = d.getFullYear()
  month = d.getMonth() + 1
  date = d.getDate()

  month = "0#{month}" if "#{month}".length is 1
  date = "0#{date}" if "#{date}".length is 1
  "#{year}-#{month}-#{date}"

prev_weight = 0
today = new Date
weights_data = for x in [0...30]
  date = date_format(new Date(today.getTime() - x * 24 * 60 * 60 * 1000))
  weight = weights[date] ? prev_weight
  prev_weight = weight

url = 'http://chart.apis.google.com/chart'
params =
  'cht=': 'lc'
  'chls=': 5
  'chco=': '76A4FB'
  'chm=': 'B,C3D9FF66,0,0,0'
  'chs=': '1000x300'
  'chd=t:': weights_data.reverse()
params = ("#{k}#{v}" for k, v of params).join '&'
img = $('<img/>').attr src:"#{url}?#{params}"

$ ->
  img.appendTo 'body'
