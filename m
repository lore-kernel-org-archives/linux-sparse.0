From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Wed, 12 Jul 2017 22:27:25 -0700
Message-ID: <CANeU7Qk8VCsj_EDBrj9H1bjR5a-_bLPQJiza_-eC90j=qiw7xw@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
 <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
 <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com>
 <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
 <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com> <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33539 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdGMF1b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Jul 2017 01:27:31 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so5600731pgb.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Jul 2017 22:27:26 -0700 (PDT)
In-Reply-To: <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 12, 2017 at 11:05 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I did raise this before
> (http://marc.info/?l=linux-sparse&m=149943353732715&w=2) but maybe it
> got lost in the other stuff.

Sorry I must miss that part. Yes. the ptrlist ref count will not able to
handle the insert and split the node. The whole idea is def the modify to
the last owner of holding the node. Insert need to split the node right there.

Even lock will not work. The inner loop guy try to get the lock and failed.
What can it do? It can't just retry because the parent is holding the lock.
It is going to be very nasty.

Any way, the patch has been updated to use a full duplicated list.
The git branch is at:
https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-next-20170712

The patch follows.

Chris

From 7264a822d9d9e545152ac675fbc5b5e970ce254b Mon Sep 17 00:00:00 2001
From: Christopher Li <sparse@chrisli.org>
Date: Wed, 12 Jul 2017 14:46:50 -0700
Subject: [PATCH] Let pseudo->users loop on duplicate versin of list

pseudo->users list will change during find dominator.
That cause a bug in the ptrlist because the outer loop iterator
is not award of the deletion of the entry.

Let the outer loop using a duplicate version of entry
to avoid this problem for now.

This is to fix the bug report by the ptrlist ref counting check.
With this change, the ptrlist ref counting check can complete
the kernel compile without reporting an error.

Signed-of-By: Christopher Li <sparse@chrisli.org>
---
 flow.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/flow.c b/flow.c
index fce8bde..bfe54f7 100644
--- a/flow.c
+++ b/flow.c
@@ -729,12 +729,21 @@ static void simplify_one_symbol(struct
entrypoint *ep, struct symbol *sym)
 multi_def:
 complex_def:
 external_visibility:
- all = 1;
- FOR_EACH_PTR_REVERSE(pseudo->users, pu) {
- struct instruction *insn = pu->insn;
- if (insn->opcode == OP_LOAD)
- all &= find_dominating_stores(pseudo, insn, ++bb_generation, !mod);
- } END_FOR_EACH_PTR_REVERSE(pu);
+ {
+ /*
+ * find_dominating_stores() will modify the pesudo->users list.
+ * Make a duplicate copy before using it.
+ */
+ struct pseudo_user_list *users = NULL;
+ all = 1;
+ concat_user_list(pseudo->users, &users);
+ FOR_EACH_PTR_REVERSE(users, pu) {
+ struct instruction *insn = pu->insn;
+ if (insn->opcode == OP_LOAD)
+ all &= find_dominating_stores(pseudo, insn, ++bb_generation, !mod);
+ } END_FOR_EACH_PTR_REVERSE(pu);
+ free_ptr_list(&users);
+ }

  /* If we converted all the loads, remove the stores. They are dead */
  if (all && !mod) {
-- 
2.9.4
