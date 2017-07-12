From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Wed, 12 Jul 2017 16:56:16 +0100
Message-ID: <CACXZuxeGmWGFbMmJCKi+aZbbxx89upb=_Vzqe7Ta99mOGHuVrg@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com>
 <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com> <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33334 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbdGLP4S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Jul 2017 11:56:18 -0400
Received: by mail-wr0-f182.google.com with SMTP id r103so39203142wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Jul 2017 08:56:17 -0700 (PDT)
In-Reply-To: <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 12 July 2017 at 06:29, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Jul 11, 2017 at 2:04 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> I think that duplicating a list because that list is being modified is
>> quite a sensible thing to do. My only suggestion would be that perhaps
>> you could have a dup() step that is separate so that you can use the
>> normal iterator macro after duplicating.
>
> So are you suggesting some thing like this:
>
> struct ptr_list *dup_list = NULL:
> concat_ptr_list(orign_list, &dup_list);
> FOR_EACH_PTR(dup_list, ptr) {
> ...
> } END_FOR_EACH_PTR(ptr);
> free_ptr_list(dup_list);
>
> I think that should work. But it come with a price
> allocating and freeing the list (otherwise it is a memory leak).

Yes that is what I meant. This is a typical solution to this type of problem.

>
> Also run slightly slower. My current way will only duplicate
> the list struct one at a time. It never duplicate the full list.
> It has fixed memory usage, no allocating, no duplicate of
> the ->next and ->prev pointer.
>

Okay - but is your approach generic enough? What if there was a split
in the node that you copied? I don't have a full understanding but it
appears to be a very specific solution rather than a general one.

> So what macro do you have in mind? I think any thing modify
> the duplicate list does not make sense.
>
> On thing I can do is rename the __list into __orig, then rename
> __dup into __list. Then most of the list macro using __list should
> work. It also means I have to use END_FOR_EACH_PTR_DUP()
> as well.
>

I was just saying that you can use the standard /existing iterator
macros once you have duplicated the list.

Regards
Dibyendu
