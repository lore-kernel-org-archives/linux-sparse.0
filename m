From: Hannes Eder <hannes@hanneseder.net>
Subject: Re: [PATCH] make sparse headers self-compilable...
Date: Tue, 11 Aug 2009 14:48:39 +0200
Message-ID: <154e089b0908110548t33b9114ej4bf3a019ee6ab80e@mail.gmail.com>
References: <200908072227.08652.kdudka@redhat.com>
	 <200908081310.27671.kdudka@redhat.com>
	 <70318cbf0908110240w5067933dv92e92829c0bb2e8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57542 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZHKMsj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Aug 2009 08:48:39 -0400
Received: by bwz19 with SMTP id 19so3142152bwz.37
        for <linux-sparse@vger.kernel.org>; Tue, 11 Aug 2009 05:48:40 -0700 (PDT)
In-Reply-To: <70318cbf0908110240w5067933dv92e92829c0bb2e8f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Kamil Dudka <kdudka@redhat.com>, sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 11, 2009 at 11:40, Christopher Li<sparse@chrisli.org> wrote:
> On Sat, Aug 8, 2009 at 4:10 AM, Kamil Dudka<kdudka@redhat.com> wrote:
>> On Friday 07 of August 2009 22:27:08 Kamil Dudka wrote:
>>> attached is another fix for SPARSE headers improving their sanity. I am
>>> also attaching a simple test for the dependency tracking of headers. It's
>>> not enough generic and portable and therefore not really useful. Maybe
>>> someone skilled in writing makefiles might want to include something like
>>> that to the SPARSE Makefile as part of the 'check' target.
>
> What is the significant of making every header file self compilable?
> Unlike the kernel header files exported to user space, which usually
> have self contained meaning. Most of these header file have tight interaction
> with each other. I don't think it make sense for other sparse application
> to just use one of the header file.
>
> Enforcing each header file to be self compilable will result in a lot
> of unnecessary include. Gcc needs to include "symbol.h" many times
> just to skip over it. Take a look at pre-process.c. It is not exactly
> trivial. It needs to scan the token to find out the end of the if
> scope. In this case, it might be better just let other header
> file depend on "symbol.h".
>
> I want to heard what other people think about it too. I am a little bit
> reluctant on this one.

What about just using some forward decls instead of including the header files?

e.g. for compile.h it is enough to have a "struct symbol;" there
instead of the "#include <symbol.h>" to make it self-compilable.

Cheers,
-Hannes
