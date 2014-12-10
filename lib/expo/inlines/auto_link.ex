defmodule Expo.Inlines.AutoLink do
  def match(line) do
    case ~r/(?<left>.*)\<(?<uri>(#{scheme_match})\:\/\/.*)\>(?<right>.*)/ |> Regex.named_captures(line) do
      %{"left" => left, "uri" => uri, "right" => right} ->
        "#{left}<a href=\"#{uri}\">#{uri}</a>#{right}"
      _ ->
        line
    end
  end

  def scheme_match do
    schemes |> List.foldl "", fn
                                scheme, "" -> scheme
                                scheme, acc -> "#{scheme}|#{acc}"
                              end
  end

  defp schemes do
    [
      "aaa", "aaas", "about", "acap", "adiumxtra", "afp", "afs", "aim", "apt", "attachment", "aw",
      "beshare", "bitcoin", "bolo",
      "callto", "cap", "chrome", "chrome-extension", "cid", "coap", "com-eventbrite-attendee", "content", "crid", "cvs",
      "data", "dav", "dict", "dlna-playsingle", "dlna-playcontainer", "dns", "doi", "dtn", "dvb",
      "ed2k",
      "facetime", "feed", "file", "finger", "fish", "ftp",
      "geo", "gg", "git", "gizmoproject", "go", "gopher", "gtalk",
      "h323", "hcp", "http", "https",
      "iax", "icap", "icon", "im", "imap", "info", "ipn", "ipp", "irc", "irc6", "ircs", "iris", "itms",
      "iris.beep", "iris.xpc", "iris.xpcs", "iris.lwz",
      "jar", "javascript", "jms",
      "keyparc",
      "lastfm", "ldap", "ldaps",
      "magnet", "mailto", "maps", "market", "message", "mid", "mms", "ms-help", "msnim", "msrp", "msrps", "mtqp", "mumble", "mupdate", "mvn",
      "news", "nfs", "ni", "nih", "nntp", "notes",
      "opaquelocktoken", "oid",
      "palm", "paparazzi", "platform", "pop", "pres", "proxy", "psyc",
      "query",
      "res", "resource", "rmi", "rsync", "rtmp", "rtsp",
      "secondlife", "service", "session", "sftp", "sgn", "shttp", "sieve", "sip", "sips", "skype", "smb", "sms", "soldat", "spotify", "ssh", "steam", "svn",
      "soap.beep", "soap.beeps",
      "tag", "teamspeak", "tel", "telnet", "tftp", "things", "thismessage", "tn3270", "tip", "tv",
      "udp", "unreal", "urn", "ut2004",
      "vemmi", "ventrilo", "view-source",
      "webcal", "ws", "wss", "wtai", "wyciwyg",
      "xcon", "xcon-userid", "xfire", "xmlrpc.beep", "xmlrpc.beeps", "xmpp", "xri",
      "ymsgr",
      "z39.50r", "z39.50s"
    ]
  end
end
