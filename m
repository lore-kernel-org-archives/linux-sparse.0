From: Nicholas Mc Guire <hofrat@hofr.at>
Subject: Re: source code transform
Date: Wed, 7 Jan 2009 22:52:45 -0900 (AKST)
Message-ID: <Pine.LNX.4.58.0901072251130.1804@vlab.hofr.at>
References: <a15fe1ffe7f7a6faf8f79d4ac780b663@mail.smartmobili.com>
 (sfid-20090107_195448_954457_6DD33448) <1231354996.3545.80.camel@johannes>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [194.112.174.227] ([194.112.174.227]:46393 "EHLO mail.hofr.at"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752370AbZAHIWf (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Jan 2009 03:22:35 -0500
In-Reply-To: <1231354996.3545.80.camel@johannes>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: mosfet <forumer@smartmobili.com>, linux-sparse@vger.kernel.org

On Wed, 7 Jan 2009, Johannes Berg wrote:

> On Wed, 2009-01-07 at 19:48 +0100, mosfet wrote:
>
> > I would like to know if sparse would be able to parse GCC source file to
> > add a comment in each function it encounters ?
> > For instance let's say I want to trace every function in c-parser.c :
> >
> >
> > static struct c_typespec
> > c_parser_enum_specifier (c_parser *parser)
> > {
> > ...
> >
> > }
> >
> > in a first step I would like to modify source code like this :
> >
> > static struct c_typespec
> > c_parser_enum_specifier (c_parser *parser)
> > {
> >  fprintf(stderr, "c-parser.c: c_parser_enum_specifier()\n");
> > ...
> >
> > }
> >
> > is it possible with sparse ?
>
> Not sure, but spatch might be able to:
>
> http://www.emn.fr/x-info/coccinelle/
>
you also could achieve this with -finstrument_functions by prviding
a cyg_func_enter function that would print the address - you then woud
have to reverse map addresses to functions via output of nm I guess.

hofrat
