From: Christopher Li <sparse@chrisli.org>
Subject: Re: more "unreplaced symbol" warnings
Date: Wed, 1 Jun 2011 00:41:02 -0700
Message-ID: <BANLkTingWZfcrf3iKZw8_vMwECm4jYnNgQ@mail.gmail.com>
References: <20110529145450.8c042971.rdunlap@xenotime.net>
	<BANLkTi=_0Xe8Fuq9aJ69Zqx3iQYq6E9N5w@mail.gmail.com>
	<20110531185831.GN11521@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65053 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab1FAHlc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Jun 2011 03:41:32 -0400
Received: by wya21 with SMTP id 21so3871451wya.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Jun 2011 00:41:31 -0700 (PDT)
In-Reply-To: <20110531185831.GN11521@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Tue, May 31, 2011 at 11:58 AM, Al Viro <viro@zeniv.linux.org.uk> wro=
te:
> Here's what is actually triggering that crap. =A0Have fun...

Here is a slightly simpler version. However I haven't figure out how th=
is happen
yet. Here is what I know so far:

1) It happens with two nested inline within one function.
    Inline bar() once the bug does not trigger.
2) It seems have some thing to do with dead statement call to inline fu=
nctions.

I am still scratching my head on that inline/uninline business. My gues=
s is that
there is some where we short circuit the inline copy due to dead
statement but some
other part of the code does not agree.

Chris

#define __u16 unsigned short
int foo(__u16 n);
static inline __u16 f(__u16 val)
{
        return val;
}

static inline unsigned int bar(__u16 n)
{
       switch (n) {
       case (1 ? 1 : f(1)):
               return 4;
       }
}

int foo(__u16 n)
{
	bar(n);
	bar(n);
	return 0;
}
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
