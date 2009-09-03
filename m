From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Thu, 3 Sep 2009 13:47:35 +0200
Message-ID: <200909031347.35371.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <200909030035.55097.kdudka@redhat.com> <70318cbf0909030242o36c07ec6re52ebc030288ac35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6657 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755024AbZICLqe (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Sep 2009 07:46:34 -0400
In-Reply-To: <70318cbf0909030242o36c07ec6re52ebc030288ac35@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Morten Welinder <terra@gnome.org>

On Thu September 3 2009 11:42:30 Christopher Li wrote:
> Can we just set the expression->ctype to the enum type
> instead of adding the *enum_type? I think the current expr->ctype
> can be reached from enum_type->ctype.base_type any way.
> In other words, we do care about expression is enum type vs int type
> in this patch.
>
> After the type evaluation(and possible warning), we can convert that
> enum type back to the base int type because the back end does not
> care about enum.

Do you want to store the correct enum type to expression->ctype and overwrite 
it later with some integral type? What's the advantage of this approach? 
(instead of preserving ABI which is already changed to 0.4.1). I don't think 
the information about type for enum constant is useful only for issuing 
warnings like this. Some SPARSE clients might also need such information.

> I think fixing the regression should be a separate patch from
> the this patch which adding new feature. It is easier to review
> as well.

Sure if anybody is able to split it... Unfortunately we have no reference for 
the "original" behavior of -Wmismatch-enum. I didn't found it documented 
anywhere and the "test-case" from the referred commit is not really useful as 
a test-case. I have not enough time for reverse engineering...

I think the tests included in the patch have good enough coverage to prevent 
you from a future regression and it sounds more important to me than 
documenting previous regressions :-)

Kamil
