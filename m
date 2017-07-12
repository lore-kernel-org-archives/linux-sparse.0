From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Wed, 12 Jul 2017 10:03:41 -0700
Message-ID: <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
 <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
 <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com> <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33001 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753514AbdGLRDm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Jul 2017 13:03:42 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so16038094pgr.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Jul 2017 10:03:42 -0700 (PDT)
In-Reply-To: <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 12, 2017 at 8:56 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>>
>
> Okay - but is your approach generic enough? What if there was a split
> in the node that you copied? I don't have a full understanding but it
> appears to be a very specific solution rather than a general one.

You have a very good point. I have never thought about splitting the
node. If split the node then there will be some ptr iterate twice. Because
some node move to the next bucket and the dup node know nothing
about it. It would be a problem for the existing code as well.

My ptrlist ref count patch haven't check the split node situation.
Even Luc's suggestion for "mark and sweep" to delete the ptrlist
is not going to help with the nested loop split. I will add that check.
I don't expect new offenders but let's make sure about it.

It means it would be so much nicer if we can avoid nested loop modify at all.

> I was just saying that you can use the standard /existing iterator
> macros once you have duplicated the list.

It was not mean to a temporary fix not generic. But may be just add
a function for duplicate list is needed for long run.

We try to avoid nest loop modify, if it has to be done. Outer loop
use a duplicated list.

Chris
