From: Pavel Roskin <proski@gnu.org>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Wed, 10 Mar 2010 15:27:21 -0500
Message-ID: <1268252841.20800.42.camel@mj>
References: <1268097872.16227.10.camel@mj>
	 <201003100030.50165.kdudka@redhat.com> <1268183362.2615.17.camel@mj>
	 <201003101705.36304.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:59414 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab0CJU1X (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Mar 2010 15:27:23 -0500
In-Reply-To: <201003101705.36304.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Wed, 2010-03-10 at 17:05 +0100, Kamil Dudka wrote:
> On Wed March 10 2010 02:09:22 Pavel Roskin wrote:
> > I wonder is the quirk handling could be skipped for EXPR_SELECT, but I'm
> > fine with it if it's harmless.
> 
> That's more likely question for sparse developers.  I have no test-case which 
> goes through the EXPR_SELECT path, so that I can't test it actually.

It looks like EXPR_CONDITIONAL is replaces with EXPR_SELECT for some
expressions, which affects code generation.  It's the same thing in
terms of syntax.  So it's fine that both are handled together.

> > When would expr or type be NULL?
> 
> Also no test-case here, but it's still better to skip the optional analysis 
> than let it crash on invalid dereference.

That makes sense for certain kinds of software, where crash is too
costly, but in case of sparse, I'd rather see it crash than ignore a
condition that may indicate an error elsewhere (perhaps both in sparse
and in the code it checks).

I thing using assert() would be a better approach.  It's already used in
sparse.

I checked the whole kernel using assert in place of the NULL checks, and
there have been no crashes.

> > We could check type in warn_for_enum_conversions().
> 
> Sure, I've just improved it.  Thanks for the hint!  Also the order of that 
> patches has been reversed, so that they are less chatty.

Maybe you could add a test case for the first patch?  What warnings does
it remove?  What is "="?  Is it assignment or initialization or both?
How about comparisons?  A better description would be nice.

-- 
Regards,
Pavel Roskin
