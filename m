From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Wed, 12 Jul 2017 19:05:50 +0100
Message-ID: <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
 <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
 <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com>
 <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com> <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33630 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdGLSFw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Jul 2017 14:05:52 -0400
Received: by mail-wr0-f177.google.com with SMTP id r103so41973370wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Jul 2017 11:05:51 -0700 (PDT)
In-Reply-To: <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 12 July 2017 at 18:03, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Jul 12, 2017 at 8:56 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>>
>>
>> Okay - but is your approach generic enough? What if there was a split
>> in the node that you copied? I don't have a full understanding but it
>> appears to be a very specific solution rather than a general one.
>
> You have a very good point. I have never thought about splitting the
> node. If split the node then there will be some ptr iterate twice. Because
> some node move to the next bucket and the dup node know nothing
> about it. It would be a problem for the existing code as well.
>
> My ptrlist ref count patch haven't check the split node situation.
> Even Luc's suggestion for "mark and sweep" to delete the ptrlist
> is not going to help with the nested loop split. I will add that check.
> I don't expect new offenders but let's make sure about it.
>

I did raise this before
(http://marc.info/?l=linux-sparse&m=149943353732715&w=2) but maybe it
got lost in the other stuff.

> It means it would be so much nicer if we can avoid nested loop modify at all.
>

I agree with that - traversing a list that is also being modified by
recursive code is pretty hard to get right.

>> I was just saying that you can use the standard /existing iterator
>> macros once you have duplicated the list.
>
> It was not mean to a temporary fix not generic. But may be just add
> a function for duplicate list is needed for long run.
>
> We try to avoid nest loop modify, if it has to be done. Outer loop
> use a duplicated list.
>

Personally I think that is a reasonable approach.

Regards
Dibyendu
