From: Chris Forbes <chrisf@ijw.co.nz>
Subject: Re: [PATCH 1/3] evaluate: warn on identical exprs around '&&'
Date: Sun, 28 Aug 2011 14:53:52 +1200
Message-ID: <CAH3ygc0xmh+w=dRhfHmD5wQ+GbZRcECFf0=GkdAEZ+ZGNeWPhg@mail.gmail.com>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
	<20110828025010.GB20823@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:50977 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab1H1Cxz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 22:53:55 -0400
Received: by yie30 with SMTP id 30so2665079yie.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 19:53:54 -0700 (PDT)
In-Reply-To: <20110828025010.GB20823@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

I'm concerned about the potential for false-positives [after
preprocessing is done] when combining a bunch of flags.

I'll throw together another patch to add &|^ support, run it against a
bunch of real codebases, and see how crazy it is.

-- Chris

On Sun, Aug 28, 2011 at 2:50 PM, Josh Triplett <josh@joshtriplett.org> =
wrote:
> On Sun, Aug 28, 2011 at 10:26:53AM +1200, Chris Forbes wrote:
>> Adds a warning when identical expressions are found on both sides of=
 the '&&' operator. This is a common error resulting from copy & paste.
>>
>> Excludes identical expressions found while preprocessing, so we don'=
t get upset about #if defined(FOO) && defined(BAR), which happens all t=
he time, and is perfectly valid.
>>
>> Signed-off-by: Chris Forbes <chrisf@ijw.co.nz>
>
> Very nice patch series! =A0I replied to patch 3 about a bit of patch =
cleanup, but otherwise this looks fine, and I've wanted to see this che=
ck for a while.
>
> Would you consider also checking for identical expresions on both sid=
es
> of an &, |, or ^? =A0The former two seem like likely cases when compo=
sing
> flags, and the latter seems like a likely error as well.
>
> Also, how does your patch handle expressions like this: *x++ && *x++
> Or this: f() && f()
>
> - Josh Triplett
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
