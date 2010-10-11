From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: including sparse headers in C++ code
Date: Mon, 11 Oct 2010 11:44:09 +0200
Message-ID: <1286790249.24953.14.camel@thorin>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	 <1286710919.24953.2.camel@thorin>  <201010101352.10864.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4370 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093Ab0JKJoe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Oct 2010 05:44:34 -0400
In-Reply-To: <201010101352.10864.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org

On Son, 2010-10-10 at 13:52 +0200, Kamil Dudka wrote: 
> On Sunday 10 October 2010 13:41:59 Bernd Petrovitsch wrote:
> > On Sam, 2010-10-09 at 14:46 -0700, Christopher Li wrote:
[...] 
> > > Well said. I don't expect sparse to compile in the C++ mode. Making
> > > sparse header usable in C++ seems reasonable to me.
> >
> > Well, sparse uses C99.
> > If one #include's <stdbool.h> at some day (as I did;-), than "true" and
> > "false" don't work any longer that good as variable names.
> 
> The clash of sparse headers with <stdbool.h> should be already fixed:
> 
> http://git.kernel.org/?p=devel/sparse/sparse.git;a=commitdiff;h=0be55c9

So far so good IMHO. But: 
----  snip  ----
{102}egrep -wc 'false|true' *.[ch] | grep -v :0
compile-i386.c:19
evaluate.c:13
expand.c:10
flow.c:10
inline.c:13
linearize.c:6
pre-process.c:3
show-parse.c:3
simplify.c:9
symbol.c:1
tokenize.c:1
----  snip  ----
There are perhaps false positives in there - but not all.

Perhaps 'sparse' should warn if one names variables, functions, and
similar "true", "false" or with any other C99 keyword.
For C++ keywords, a different option is probably best.

Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

