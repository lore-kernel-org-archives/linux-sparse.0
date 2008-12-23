From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Casting away noderef and address spaces?
Date: Mon, 22 Dec 2008 19:02:58 -0800
Message-ID: <70318cbf0812221902q23f00644h3af3eed6fa0138de@mail.gmail.com>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
	 <20081222205750.GK28946@ZenIV.linux.org.uk>
	 <200812231244.22614.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_68671_2695806.1230001378150"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:51334 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbYLWDC7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 22:02:59 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2191924rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 19:02:58 -0800 (PST)
In-Reply-To: <200812231244.22614.rusty@rustcorp.com.au>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

------=_Part_68671_2695806.1230001378150
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, Dec 22, 2008 at 6:14 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> rusty@vivaldi:/tmp$ sparse foo.c
> foo.c:11:20: warning: incorrect type in assignment (invalid types)
> foo.c:11:20:    expected unknown type 11<noident>
> foo.c:11:20:    got int
>

I think you need this patch for sparse. The version of sparse you
have does not handle typeof based type compare yet.

Chris

------=_Part_68671_2695806.1230001378150
Content-Type: application/octet-stream; name=evaluate-typeof
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fp1yvsr30
Content-Disposition: attachment; filename=evaluate-typeof

VGVhY2ggY2xhc3NpZnlfdHlwZSB0byBoYW5kbGUgdHlwZW9mCgpTaWduZWQtT2ZmLUJ5OiBDaHJp
c3RvcGhlciBMaSA8c3BhcnNlQGNocmlzbGkub3JnPgoKSW5kZXg6IHNwYXJzZS9ldmFsdWF0ZS5j
Cj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KLS0tIHNwYXJzZS5vcmlnL2V2YWx1YXRlLmMKKysrIHNwYXJzZS9ldmFsdWF0
ZS5jCkBAIC0zNjIsNiArMzYyLDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IGNsYXNzaWZ5X3R5cGUo
c3RydWN0IHMKIAl9OwogCWlmICh0eXBlLT50eXBlID09IFNZTV9OT0RFKQogCQl0eXBlID0gdHlw
ZS0+Y3R5cGUuYmFzZV90eXBlOworCWlmICh0eXBlLT50eXBlID09IFNZTV9UWVBFT0YpIHsKKwkJ
dHlwZSA9IGV2YWx1YXRlX2V4cHJlc3Npb24odHlwZS0+aW5pdGlhbGl6ZXIpOworCQlpZiAodHlw
ZS0+dHlwZSA9PSBTWU1fTk9ERSkKKwkJCXR5cGUgPSB0eXBlLT5jdHlwZS5iYXNlX3R5cGU7CisJ
fQogCWlmICh0eXBlLT50eXBlID09IFNZTV9FTlVNKQogCQl0eXBlID0gdHlwZS0+Y3R5cGUuYmFz
ZV90eXBlOwogCSpiYXNlID0gdHlwZTsK
------=_Part_68671_2695806.1230001378150--
