From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 21:19:49 +0200
Message-ID: <200909022119.50213.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <200909021823.36662.kdudka@redhat.com> <20090902190337.GB5148@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23620 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752248AbZIBTUt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 15:20:49 -0400
In-Reply-To: <20090902190337.GB5148@josh-work.beaverton.ibm.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Wednesday 02 of September 2009 21:03:41 Josh Triplett wrote:
> Don't worry about this change.  I only suggested it as a potential
> simplification, but it doesn't need to happen as part of this patch.
> I'd rather see the patch get merged in its current form (plus the test
> suite additions), rather than poking at simplifications like this that
> don't immediately prove trivial.  Those can always happen later. :)

Nope, I think we should fix it right now. And if possible ask the original 
authors for review and/or comment at the patch I am currently preparing.
I considered it pretty broken. Just try this example:

static void f(void) {
    enum ENUM_TYPE_A { VALUE_A } var_a;
    enum ENUM_TYPE_B { VALUE_B } var_b;

    switch (var_a) {
        case VALUE_A:
        case VALUE_B:
        default:
            break;
    }
}

It seems like this was the original intention of the calling the 
warn_for_different_enum_types() from check_case_type(). But it has been 
either not tested, or broken in the meantime.

> Either one seems fine; I don't think splitting the test case helps
> coverage, and keeping it together lets you use the same declarations for
> the entire test case as you did in the previously attached version.

This is not necessarily dedicated to choice 1), unless you are scared from
a construction like this:

    #include "enum-common.c"

> However, I wonder if it would make sense to have the same test case run
> multiple times with different warning options and correspondingly
> different output, to make sure the warnings stay associated with the
> right flag?  Given the current test framework, that would unfortunately
> involve some duplication, but it still seems worth doing.

I think the choice 2) slightly wins (counting me and Chris for now)...

Kamil
