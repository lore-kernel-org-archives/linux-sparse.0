From: Christopher Li <sparse@chrisli.org>
Subject: Re: including sparse headers in C++ code
Date: Sat, 9 Oct 2010 14:46:08 -0700
Message-ID: <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<20101009205930.GA4684@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60630 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096Ab0JIVqK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Oct 2010 17:46:10 -0400
Received: by iwn6 with SMTP id 6so1765176iwn.19
        for <linux-sparse@vger.kernel.org>; Sat, 09 Oct 2010 14:46:09 -0700 (PDT)
In-Reply-To: <20101009205930.GA4684@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org

On Sat, Oct 9, 2010 at 1:59 PM, Josh Triplett <josh@joshtriplett.org> w=
rote:
> It seems reasonable to avoid the use of C++ keywords in Sparse *heade=
rs*
> (though unnecessary in *source*). =A0Looks like this will primarily c=
ause
> pain due to "enum namespace" and the various places using it. =A0Seem=
s
> easy enough to change those all to "ns". =A0"new" mostly seems to get=
 used
> as a parameter name or local variable name; for the former we could o=
mit
> it, and for the latter we could trivially call it something more
> specific like "newlist" or "newptr".
>
> So, I'd tend to guess "patches welcome" (again, for headers only, plu=
s
> minimal corresponding source changes when required). =A0I wouldn't
> anticipate other Sparse developers objecting strongly, but if they do
> your mail seems like the right way to find out. =A0The various reason=
s
> given for *not* making the Linux kernel headers compatible don't seem=
 to
> apply here, though.

Well said. I don't expect sparse to compile in the C++ mode. Making
sparse header usable in C++ seems reasonable to me.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
