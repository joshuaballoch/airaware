$(document).ready () ->
  locale = $('meta[name="locale"]').attr('content')
  console.log locale
  if locale == "zh-CN"
    jQuery.timeago.settings.strings = {
      prefixAgo: null,
      prefixFromNow: "从现在开始",
      suffixAgo: "之前",
      suffixFromNow: null,
      seconds: "不到 1 分钟",
      minute: "大约 1 分钟",
      minutes: "%d 分钟",
      hour: "大约 1 小时",
      hours: "大约 %d 小时",
      day: "1 天",
      days: "%d 天",
      month: "大约 1 个月",
      months: "%d 月",
      year: "大约 1 年",
      years: "%d 年",
      numbers: [],
      wordSeparator: ""
    };
  else
    jQuery.timeago.settings.strings = {
      prefixAgo: null,
      prefixFromNow: null,
      suffixAgo: "ago",
      suffixFromNow: "from now",
      seconds: "less than a minute",
      minute: "about a minute",
      minutes: "%d minutes",
      hour: "about an hour",
      hours: "about %d hours",
      day: "a day",
      days: "%d days",
      month: "about a month",
      months: "%d months",
      year: "about a year",
      years: "%d years",
      wordSeparator: " ",
      numbers: []
    };

