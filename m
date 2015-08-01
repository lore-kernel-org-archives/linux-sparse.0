From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Sat, 1 Aug 2015 11:45:38 -0700
Message-ID: <CANeU7QkK5N8Jskcq9J1ODCeZEQYSAJTW-6PdKg1uuZeNXPYKTA@mail.gmail.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
	<1438216001-8862-4-git-send-email-tcamuso@redhat.com>
	<20150730025502.GA1692@x>
	<55BA0E4E.7000508@redhat.com>
	<CANeU7Qm=nv85N6MWZ=Lo=OLWEmyEOOk84AHbBwFAgfUfhBonbg@mail.gmail.com>
	<55BCA8D2.1040808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33741 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbHASpj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Aug 2015 14:45:39 -0400
Received: by ykek23 with SMTP id k23so9962964yke.0
        for <linux-sparse@vger.kernel.org>; Sat, 01 Aug 2015 11:45:39 -0700 (PDT)
In-Reply-To: <55BCA8D2.1040808@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 1, 2015 at 4:09 AM, Tony Camuso <tcamuso@redhat.com> wrote:
>
> I've since submitted a runtime patch (3/3 V3) with a switch as a
> response to this patch, but it basically does the same thing here.
>
> Consider the case where the source contains something like this...
>
>         struct foo {
>                 union {
>                         int number;
>                         int *pointer;
>                 };
>         };
>
> There being no ident for the union within the struct, we get the warning,
> "missing identifier in declaration" etc.
>

I can't reproduce the warning with the chrisl repo master branch.

That being said, if there is indeed a bug in sparse, it should be a
separate patch. It changes the parsing behavior.

Thanks

Chris
