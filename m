From: Christopher Li <sparse@chrisli.org>
Subject: Re: including sparse headers in C++ code
Date: Sun, 17 Oct 2010 20:16:22 -0700
Message-ID: <AANLkTikQ8OXUtoAd1Jn+Awn+4RXCEF6=_NAz1Xiq0WW-@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<20101009205930.GA4684@feather>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<AANLkTi=8EkK+_9pOA8fbDgYGfz-bPGj6XhLUnfSkdGeV@mail.gmail.com>
	<20101011224656.GN19804@ZenIV.linux.org.uk>
	<AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
	<AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
	<AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
	<AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
	<20101016191153.GA19324@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34114 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab0JRDQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Oct 2010 23:16:26 -0400
Received: by iwn35 with SMTP id 35so612700iwn.19
        for <linux-sparse@vger.kernel.org>; Sun, 17 Oct 2010 20:16:22 -0700 (PDT)
In-Reply-To: <20101016191153.GA19324@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Tomas Klacko <tomas.klacko@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

On Sat, Oct 16, 2010 at 12:11 PM, Josh Triplett <josh@joshtriplett.org>=
 wrote:
> Huh, interesting. =A0Turns out that giant union contains two differen=
t
> structs of the form { struct symbol *, struct statement * }; one for
> label_arg and one for labeled_struct. =A0They have different names fo=
r the
> symbol, but the same name for the statement. =A0We should fix that fo=
r C
> as well, either by renaming one of the statements, or by just making
> both variations use the same set of fields and dropping one of the
> sub-structs. =A0Either way, that should happen as an independent patc=
h,
> separate from the C++ compatibility changes.

That make sense. It seems to me that label_arg is not actually used.
It might used in very early code.  The member statement->label is never
referenced now. There is no point to keep it as far as I can tell.
Just remove that  label_arg union and sparse compile just fine.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
