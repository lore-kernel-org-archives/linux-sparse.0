From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Thu, 3 Sep 2009 11:38:24 -0700
Message-ID: <70318cbf0909031138s4c066005vcd8b8f614723b05f@mail.gmail.com>
References: <20090830153202.4dc5c58c@s6510>
	 <200909030035.55097.kdudka@redhat.com>
	 <70318cbf0909030242o36c07ec6re52ebc030288ac35@mail.gmail.com>
	 <200909031347.35371.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:38563 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbZICSi1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Sep 2009 14:38:27 -0400
Received: by vws33 with SMTP id 33so171393vws.33
        for <linux-sparse@vger.kernel.org>; Thu, 03 Sep 2009 11:38:28 -0700 (PDT)
In-Reply-To: <200909031347.35371.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Morten Welinder <terra@gnome.org>

On Thu, Sep 3, 2009 at 4:47 AM, Kamil Dudka<kdudka@redhat.com> wrote:
> Do you want to store the correct enum type to expression->ctype and overwrite
> it later with some integral type? What's the advantage of this approach?
> (instead of preserving ABI which is already changed to 0.4.1). I don't think
> the information about type for enum constant is useful only for issuing
> warnings like this. Some SPARSE clients might also need such information.

I think it is cleaner to have one single place to look for the ctype of
an expression.We don't have to convert it to int type. I think most of the
sparse code can deal with enum type any way. I don't like the dual personality
of expressions.

An other reason is that you increase the expression structure size for
32 bit system. Expression and symbol are the most common used
structure. It take up a good portion of the sparse memory foot print. I
want to keep them as lean as possible.

> Sure if anybody is able to split it... Unfortunately we have no reference for
> the "original" behavior of -Wmismatch-enum. I didn't found it documented
> anywhere and the "test-case" from the referred commit is not really useful as
> a test-case. I have not enough time for reverse engineering...

I don't see why it is hard to split. Can we just make the code which add
new options and issue new warnings to a separate patch? We shouldn't
need to reverse engineering the old behavior to do that.

>
> I think the tests included in the patch have good enough coverage to prevent
> you from a future regression and it sounds more important to me than
> documenting previous regressions :-)

Yes I agree the test case is always useful.

Chris
