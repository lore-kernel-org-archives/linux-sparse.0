From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Thu, 3 Sep 2009 02:42:30 -0700
Message-ID: <70318cbf0909030242o36c07ec6re52ebc030288ac35@mail.gmail.com>
References: <20090830153202.4dc5c58c@s6510>
	 <20090902190337.GB5148@josh-work.beaverton.ibm.com>
	 <200909022119.50213.kdudka@redhat.com>
	 <200909030035.55097.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:35368 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbZICJm1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Sep 2009 05:42:27 -0400
Received: by mail-vw0-f195.google.com with SMTP id 33so552317vws.33
        for <linux-sparse@vger.kernel.org>; Thu, 03 Sep 2009 02:42:30 -0700 (PDT)
In-Reply-To: <200909030035.55097.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Morten Welinder <terra@gnome.org>

On Wed, Sep 2, 2009 at 3:35 PM, Kamil Dudka<kdudka@redhat.com> wrote:
> On Wednesday 02 of September 2009 21:19:49 Kamil Dudka wrote:
>
> The second holds. It's regression!

I have some questions regarding your patch:

Can we just set the expression->ctype to the enum type
instead of adding the *enum_type? I think the current expr->ctype
can be reached from enum_type->ctype.base_type any way.
In other words, we do care about expression is enum type vs int type
in this patch.

After the type evaluation(and possible warning), we can convert that
enum type back to the base int type because the back end does not
care about enum.

I think fixing the regression should be a separate patch from
the this patch which adding new feature. It is easier to review
as well.

Sorry the rest of the patch will take me more time to go over.

Chris
