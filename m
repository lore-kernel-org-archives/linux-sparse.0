From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] Add NOWARN and NOERR compile conditions
Date: Fri, 31 Jul 2015 16:46:25 -0700
Message-ID: <CANeU7Qm=nv85N6MWZ=Lo=OLWEmyEOOk84AHbBwFAgfUfhBonbg@mail.gmail.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
	<1438216001-8862-4-git-send-email-tcamuso@redhat.com>
	<20150730025502.GA1692@x>
	<55BA0E4E.7000508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34292 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbbGaXq0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 31 Jul 2015 19:46:26 -0400
Received: by ykax123 with SMTP id x123so71653721yka.1
        for <linux-sparse@vger.kernel.org>; Fri, 31 Jul 2015 16:46:25 -0700 (PDT)
In-Reply-To: <55BA0E4E.7000508@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 30, 2015 at 4:45 AM, Tony Camuso <tcamuso@redhat.com> wrote:
>
> I thought it would be less intrusive, since I don't know how useful
> this would be to others.
>
> If you prefer a switch, I will do that.

I agree that this should be run time behavior.

+
+#if defined NOWARN || defined NOERR
+               return token->next;
+#else

What is up with this change? It is not output warning or not.
It affect the parsing as well. If sparse can't bail out properly,
this should be a separate patch.

Chris
