From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Tue, 9 Mar 2010 21:29:15 +0100
Message-ID: <201003092129.16118.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <20100309191551.GB4586@feather> <1268165517.23196.22.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47505 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab0CIUbs (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Mar 2010 15:31:48 -0500
In-Reply-To: <1268165517.23196.22.camel@mj>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tuesday 09 of March 2010 21:11:57 Pavel Roskin wrote:
> Ironically, the fix for :? may benefit from that operator:
>
> do_warn_for_enum_conversions(expr->cond_true ?: expr->conditional, type);

Yeah, that's exactly what I've tried ;-)

> do_warn_for_enum_conversions(expr->cond_false ?: expr->conditional, type);

Does it mean the cond_false may be also omitted?  I can't image how the enum 
conversion analysis can be useful in that case.  I've ensured the optional 
analysis would no more crash on another corner case in the first place:

--- a/evaluate.c
+++ b/evaluate.c
@@ -327,13 +327,35 @@ warn_for_int_to_enum_conversion (struct expression 
*expr, struct symbol *typeb)
 }

 static void
-warn_for_enum_conversions(struct expression *expr, struct symbol *type)
+do_warn_for_enum_conversions(struct expression *expr, struct symbol *type)
 {
+       if (!expr || !type)
+               /* do not crash when there is nothing to check */
+               return;
+
        warn_for_different_enum_types (expr, type);
        warn_for_enum_to_int_conversion (expr, type);
        warn_for_int_to_enum_conversion (expr, type);
 }

> At least I was able to run sparse on the whole kernel (wireless-testing,
> which is based on 2.6.34-rc1) without crashing or reporting anything
> strange.
>
> Actually, omitting the false conditional appears to be invalid.

Unfortunately it's not that easy.  I am still getting a non-sense warning for:

static void foo(void)
{
    enum { VAL } y, x = VAL;
    y = x ?: VAL;
}

$ ./sparse enum.c
enum.c:4:9: warning: conversion of
enum.c:4:9:     int to
enum.c:4:9:     int enum <noident>

I need to somehow get over the EXPR_IMPLIED_CAST to dig the original enum_type 
from there...

Kamil
