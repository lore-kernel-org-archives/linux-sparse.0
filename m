From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Wed, 19 Jul 2017 14:42:33 -0700
Message-ID: <CANeU7QmQ4JmD_wLoZ6r7bV7Uu4BASnvuHpmQ7VKAoZXR9FD93w@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
 <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
 <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com>
 <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
 <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com>
 <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
 <CANeU7Qk8VCsj_EDBrj9H1bjR5a-_bLPQJiza_-eC90j=qiw7xw@mail.gmail.com> <20170719211437.7axhrrjrvr4k6dvg@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33139 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbdGSVme (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 17:42:34 -0400
Received: by mail-pg0-f46.google.com with SMTP id k14so5652548pgr.0
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 14:42:34 -0700 (PDT)
In-Reply-To: <20170719211437.7axhrrjrvr4k6dvg@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 19, 2017 at 2:14 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> When I see this description, the first thing I think is:
> "you have a problem with an object, you duplicate the object,
>  not you have two problem (at least)".
> In short, how you will keep coherency between the two?

We don't :-). Both the remove case and insert case has been
discussed. First of all, the ptrlist-refcount patch check for the
insert case, there is none so far. If you believe there is one,
I would like to know.

About the looping on the deleted entry. That is the very first
thing I shout in the V1 version of the patch. The thing is,
the pseudo_user have a point to instruction. If the instruction
is deleted then that instruction will have insn->bb = NULL.

Not a perfect fix. But better than the previous. Because
the for loop is actually looping on reverse order. Any delete
will cause major align problem __nr counting from the tail.

Any way, My V1 and email asking for suggestion how to fix it
About 10 days  ago. I haven't heard any thing better. If you
have other way to fix it properly, I am all for it. It is not too late
but time is running out soon.

Chris
