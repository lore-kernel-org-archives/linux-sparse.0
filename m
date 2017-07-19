From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Wed, 19 Jul 2017 23:14:40 +0200
Message-ID: <20170719211437.7axhrrjrvr4k6dvg@ltop.local>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
 <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
 <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com>
 <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
 <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com>
 <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
 <CANeU7Qk8VCsj_EDBrj9H1bjR5a-_bLPQJiza_-eC90j=qiw7xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38814 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbdGSVOn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 17:14:43 -0400
Received: by mail-wm0-f47.google.com with SMTP id w191so10068835wmw.1
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 14:14:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk8VCsj_EDBrj9H1bjR5a-_bLPQJiza_-eC90j=qiw7xw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 12, 2017 at 10:27:25PM -0700, Christopher Li wrote:
> From 7264a822d9d9e545152ac675fbc5b5e970ce254b Mon Sep 17 00:00:00 2001
> From: Christopher Li <sparse@chrisli.org>
> Date: Wed, 12 Jul 2017 14:46:50 -0700
> Subject: [PATCH] Let pseudo->users loop on duplicate versin of list
> 
> pseudo->users list will change during find dominator.
> That cause a bug in the ptrlist because the outer loop iterator
> is not award of the deletion of the entry.
> 
> Let the outer loop using a duplicate version of entry
> to avoid this problem for now.

When I see this description, the first thing I think is:
"you have a problem with an object, you duplicate the object,
 not you have two problem (at least)".
In short, how you will keep coherency between the two?

So yes, without any doubts, this fixes the iteration in the outer loop
not taking correctly in account the deletion in the inner loop.

But is the code working correctly now? I don't think so.
In fact, since the outer loop is using a copy of the initial list,
now *any* changes in the list will siply be ignored by the outer loop.
- if an user is removed from the users list (for example in a
  position much further than the current position in the inner),
  previously, the inner loop will of course not have processed
  this user, while now it will process it although this user no
  more a user of this pseudo.
  It there any explanation which could explain that the current
  behaviour is correct?
- same if the inner loop add a new user, now the outer loop will
  never process this user.

To be clear, the issue I'm raising here is not about 'maybe missing
an optimisation' but well a question of applying an optimization
while the real condition are in fatc not met, and thus producings
incorrect code.

-- Luc
