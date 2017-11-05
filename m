From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Simplify expr->flags assignement
Date: Sun, 5 Nov 2017 02:54:49 -0500
Message-ID: <CANeU7Qn=cU4xxiweJf0KHCgCcLQxabmfUJ5NNEjj+d9rWyKFnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:54007 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbdKEHyv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 02:54:51 -0500
Received: by mail-yw0-f196.google.com with SMTP id q126so5564754ywq.10
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 00:54:50 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Some back ground of this patch. After the I merge the constant
expression series. I have setup my build machine to run some
repeated stress test again each of the commit change. Each change
has run 5 times and there is beak time between each stress run
to allow the machine cool down.

I am looking for the change that cause the biggest jump in the commit
series. So that brings me to a patch in the series introduce the flags.
I make some simplification on it. That is this patch.

For the record, Here is the timing run back then with and without
this patch, each has 5 run. It is hard to tell, but it seems the
stress test can confirm the patch make a tiny little bit of difference.
Big deal. :-)

It has been a while, I might just sending it out before I forget
about it.

Chris

$ stress.py exp 0 1
# cpus 24
exp~0 dc9902c Simplify expr->flags assignement

real 1m18.737s
user 20m54.255s
sys 7m37.059s

real 1m18.886s
user 20m55.832s
sys 7m35.513s

real 1m18.900s
user 20m56.276s
sys 7m35.648s

real 1m18.759s
user 20m53.276s
sys 7m37.484s

real 1m18.829s
user 20m55.247s
sys 7m36.025s
exp~1 17c0bae constexpr: flag __builtin_bswap() as constexpr

real 1m18.959s
user 20m55.826s
sys 7m37.334s

real 1m18.909s
user 20m57.096s
sys 7m36.704s

real 1m18.906s
user 20m57.002s
sys 7m36.329s

real 1m18.789s
user 20m56.551s
sys 7m36.875s

real 1m18.964s
user 20m56.409s
sys 7m37.103s


The same patch can be fetch on:

https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=simplify-context-expr

From 6d83f6ecb4e33b981ad6ec302be50d679ec2c3e9 Mon Sep 17 00:00:00 2001
From: Christopher Li <sparse@chrisli.org>
Date: Thu, 24 Aug 2017 01:24:52 -0400
\
---
 evaluate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index b96696d3..9715b71d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -906,8 +906,8 @@ static struct symbol *evaluate_logical(struct
expression *expr)

        /* the result is int [6.5.13(3), 6.5.14(3)] */
        expr->ctype = &int_ctype;
-       expr->flags = expr->left->flags & expr->right->flags;
-       expr->flags &= ~(CEF_CONST_MASK | CEF_ADDR);
+       expr->flags = expr->left->flags & expr->right->flags
+                       & ~(CEF_CONST_MASK | CEF_ADDR);
        return &int_ctype;
 }

@@ -920,8 +920,8 @@ static struct symbol *evaluate_binop(struct
expression *expr)

        /* number op number */
        if (lclass & rclass & TYPE_NUM) {
-               expr->flags = expr->left->flags & expr->right->flags;
-               expr->flags &= ~CEF_CONST_MASK;
+               expr->flags = expr->left->flags & expr->right->flags
+                               & ~CEF_CONST_MASK;

                if ((lclass | rclass) & TYPE_FLOAT) {
                        switch (op) {
@@ -1036,7 +1036,7 @@ static struct symbol *evaluate_compare(struct
expression *expr)
        if (is_safe_type(left->ctype) || is_safe_type(right->ctype))

-       expr->flags = left->flags & right->flags & ~CEF_CONST_MASK & ~CEF_ADDR;
+       expr->flags = left->flags & right->flags & ~(CEF_CONST_MASK | CEF_ADDR);

        /* number on number */
        if (lclass & rclass & TYPE_NUM) {
@@ -1914,12 +1914,11 @@ static struct symbol *evaluate_preop(struct
expression *expr)
                return evaluate_postop(expr);

        case '!':
-               expr->flags = expr->unop->flags & ~CEF_CONST_MASK;
                /*
                 * A logical negation never yields an address constant
                 * [6.6(9)].
                 */
-               expr->flags &= ~CEF_ADDR;
+               expr->flags = expr->unop->flags & ~(CEF_CONST_MASK | CEF_ADDR);

                if (is_safe_type(ctype))
                        warning(expr->pos, "testing a 'safe expression'");
-- 
2.13.6
