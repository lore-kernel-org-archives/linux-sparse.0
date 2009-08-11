From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] make sparse headers self-compilable...
Date: Tue, 11 Aug 2009 11:55:19 +0200
Message-ID: <200908111155.19586.kdudka@redhat.com>
References: <200908072227.08652.kdudka@redhat.com> <200908081310.27671.kdudka@redhat.com> <70318cbf0908110240w5067933dv92e92829c0bb2e8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:38853 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753093AbZHKMIx (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Aug 2009 08:08:53 -0400
In-Reply-To: <70318cbf0908110240w5067933dv92e92829c0bb2e8f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: sparse <linux-sparse@vger.kernel.org>

On Tuesday 11 of August 2009 11:40:45 Christopher Li wrote:
> What is the significant of making every header file self compilable?
> Unlike the kernel header files exported to user space, which usually
> have self contained meaning. Most of these header file have tight
> interaction with each other. I don't think it make sense for other sparse
> application to just use one of the header file.
>
> Enforcing each header file to be self compilable will result in a lot
> of unnecessary include. Gcc needs to include "symbol.h" many times
> just to skip over it. Take a look at pre-process.c. It is not exactly
> trivial. It needs to scan the token to find out the end of the if
> scope. In this case, it might be better just let other header
> file depend on "symbol.h".

Then an ordinary SPARSE user needs to try various permutation of the includes 
to pass his hello-world through compiler. It could be really annoying. I'd 
like to have all includes in alphabetical order because it's then easier to 
maintenance.

If you really want to have external dependencies of SPARSE headers (no matter 
what reason for), the dependencies should be exactly documented somewhere - 
maybe in the headers themselves?

What about replacing my '#include "allocate.h"' with comment '// ATTENTION: 
you have to include allocate.h before storage.h'?

> I want to heard what other people think about it too. I am a little bit
> reluctant on this one.

No problem with me as it has easy workaround.

Kamil
