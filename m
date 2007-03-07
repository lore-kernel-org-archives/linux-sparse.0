From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: sparse segfault in kernel -mm tree
Date: Tue, 6 Mar 2007 20:13:17 -0800
Message-ID: <20070306201317.5acb11b6.rdunlap@xenotime.net>
References: <20070305175322.cbe0bb66.rdunlap@xenotime.net>
	<20070306023351.GB31138@chrisli.org>
	<20070305210416.7b5c0a2a.rdunlap@xenotime.net>
	<20070306004243.lvpk4ss8w8okw4ss@webmail.spamcop.net>
	<20070305224025.fe867c28.rdunlap@xenotime.net>
	<1173205177.32333.34.camel@dv>
	<20070306125846.0e3a684a.rdunlap@xenotime.net>
	<70318cbf0703061428u138a64b2x117eebdb915be50@mail.gmail.com>
	<20070306190443.b8162bff.rdunlap@xenotime.net>
	<70318cbf0703061912k73f19092p2f74ab7d4ae80afb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:42348 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161264AbXCGEPQ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 6 Mar 2007 23:15:16 -0500
Received: from midway.site ([71.245.96.156]) by xenotime.net for <linux-sparse@vger.kernel.org>; Tue, 6 Mar 2007 20:15:05 -0800
In-Reply-To: <70318cbf0703061912k73f19092p2f74ab7d4ae80afb@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Tue, 6 Mar 2007 19:12:53 -0800 Christopher Li wrote:

> It seems that you are missing this change:
> 
> user:        Christopher Li <sparse@chrisli.org>
> date:        Thu Feb 22 18:28:23 2007 -0800
> summary:     Fix the segfault when initializer has unknown symbol
> 
> diff -r 9c425042a094 -r d22e36f6c600 expand.c
> --- a/expand.c  Wed Feb 21 14:05:52 2007 -0800
> +++ b/expand.c  Thu Feb 22 18:28:23 2007 -0800
> @@ -872,7 +872,7 @@ static void verify_nonoverlapping(struct
>         struct expression *b;
> 
>         FOR_EACH_PTR(*list, b) {
> -               if (a && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
> +               if (a && a->ctype && a->ctype->bit_size &&
> bit_offset(a) == bit_offset(b)) {
>                         sparse_error(a->pos, "Initializer entry defined twice");
>                         info(b->pos, "  also defined here");
>                         return;
> 
> Many be the snapshot script need a restart again?

Hi,
OK, I hope that's it.  I'll check it out soon.
If that doesn't fix it, I'll post the .i file.

Thanks.

> Chris
> 
> On 3/6/07, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > On Tue, 6 Mar 2007 14:28:24 -0800 Christopher Li wrote:
> > 875                     if (a && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
> > (gdb) bt
> > #0  0x000000000040fd63 in expand_expression (expr=<value optimized out>)



---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
