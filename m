From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Thu, 13 Jul 2017 05:23:10 -0700
Message-ID: <CANeU7Q=0X1gdjotU6=KxduBS38b1yK3CGexUD7FBEWdemT7Aig@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
 <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
 <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com>
 <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
 <CANeU7Qk+81ABEnGLxwbHnx510JWk7U8s=RnFqm_jM8pj-4EyDw@mail.gmail.com> <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35295 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdGMMXL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Jul 2017 08:23:11 -0400
Received: by mail-pg0-f41.google.com with SMTP id j186so28868343pge.2
        for <linux-sparse@vger.kernel.org>; Thu, 13 Jul 2017 05:23:11 -0700 (PDT)
In-Reply-To: <CACXZuxfxUDJKGcH6wFhnxmfXM9jxmMOKyO=5zswQvfGbE88=sw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 12, 2017 at 11:05 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>> My ptrlist ref count patch haven't check the split node situation.
>> Even Luc's suggestion for "mark and sweep" to delete the ptrlist
>> is not going to help with the nested loop split. I will add that check.
>> I don't expect new offenders but let's make sure about it.
>>
>
> I did raise this before
> (http://marc.info/?l=linux-sparse&m=149943353732715&w=2) but maybe it
> got lost in the other stuff.

I add a check to the ptrlist refcount patch to look for insert inside
nested loop. Just as I expected,  running the full kernel source check
did not reveal any such situation. That is a good news in a sense.

Chris
