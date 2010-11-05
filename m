From: Christopher Li <sparse@chrisli.org>
Subject: Re: including sparse headers in C++ code
Date: Thu, 4 Nov 2010 17:57:47 -0700
Message-ID: <AANLkTinmmLf9dMvLfWk09kGV6RbEo9HMV8ds=yGEQyMw@mail.gmail.com>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	<AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	<1286710919.24953.2.camel@thorin>
	<201010101352.10864.kdudka@redhat.com>
	<1286790249.24953.14.camel@thorin>
	<AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
	<20101011191219.GD8537@feather>
	<1286981110.14103.86.camel@thorin>
	<20101020072945.GA3232@ZenIV.linux.org.uk>
	<1287567544.7542.7.camel@thorin>
	<AANLkTikBMpuwHZpAsSmcP_5MC3GJQNZE3SrRT6VQ8boS@mail.gmail.com>
	<1288358560.7795.34.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47882 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab0KEA5s (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Nov 2010 20:57:48 -0400
Received: by iwn41 with SMTP id 41so187802iwn.19
        for <linux-sparse@vger.kernel.org>; Thu, 04 Nov 2010 17:57:47 -0700 (PDT)
In-Reply-To: <1288358560.7795.34.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kamil Dudka <kdudka@redhat.com>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>

On Fri, Oct 29, 2010 at 6:22 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
>
> Voila.

-               struct basic_block *true = br->bb_true;
-               struct basic_block *false = br->bb_false;
-               br->bb_false = true;
-               br->bb_true = false;
+               struct basic_block *true_expr = br->bb_true;
+               struct basic_block *false_expr = br->bb_false;
+               br->bb_false = true_expr;
+               br->bb_true = false_expr;

Hmm, not very "true" symbol is an expression type. You end up calling
basicl_block pointer as true_expr, that is misleading.
Same thing happen to pseudo_t pointers.

Looks fine otherwise.

Chris
