From: Thomas Schmid <Thomas.Schmid@br-automation.com>
Subject: [PATCH] Fix implicit cast to float (Was:Re: Initializing float variables
 without type suffix)
Date: Fri, 6 Feb 2009 13:51:34 +0100
Message-ID: <OFA9A147C1.624E6D79-ONC1257555.00437599-C1257555.00469A67@br-automation.com>
References: <70318cbf0902052015i387c5e18w475704b290904e61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:52325 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZBFMvW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Feb 2009 07:51:22 -0500
In-Reply-To: <70318cbf0902052015i387c5e18w475704b290904e61@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: christ.li@gmail.com, Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org

christ.li@gmail.com schrieb am 06.02.2009 05:15:37:

> cast_to() seems fine.
> 
> In expanding stage, cast_value() did not cast the constant
> correctly.

You're right, I also noticed this in the meantime.
The decision, whether newtype is int_type or fp_type is not made 
correctly.

The following patch seems to work:

Fix implicit cast to float

Signed-Off-By: Thomas Schmid <Thomas.Schmid@br-automation.com>

Index: sparse/expand.c
===================================================================
--- sparse.orig/expand.c        2009-02-06 11:37:17.717913100 +0100
+++ sparse/expand.c     2009-02-06 11:37:34.973482600 +0100
@@ -116,7 +116,7 @@ Int:
        return;
 
 Float:
-       if (newtype->ctype.base_type != &fp_type) {
+       if (is_int_type(newtype)) {
                value = (long long)old->fvalue;
                expr->type = EXPR_VALUE;
                expr->taint = 0;
@@ -126,7 +126,7 @@ Float:
        if (oldtype->ctype.base_type != &fp_type)
                expr->fvalue = (long double)get_longlong(old);
        else
-               expr->fvalue = old->value;
+               expr->fvalue = old->fvalue;
 
        if (!(newtype->ctype.modifiers & MOD_LONGLONG)) {
                if ((newtype->ctype.modifiers & MOD_LONG))
