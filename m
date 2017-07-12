From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Tue, 11 Jul 2017 22:29:36 -0700
Message-ID: <CANeU7QkTAQ6XaAGrd1PmQ_4Jcv2vxD-cK_9+kKFbyX5b+Pg+Wg@mail.gmail.com>
References: <CANeU7QmpvfZutvnSwrjH7ZYXhw3S3HDh19eHXkBGY7oz7ADtmw@mail.gmail.com>
 <CANeU7Q=d_+QD+MSGyYqwL82M2RdC_AFVaeR-y87z3U3OKjNBKw@mail.gmail.com> <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35061 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756678AbdGLF3i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Jul 2017 01:29:38 -0400
Received: by mail-pg0-f51.google.com with SMTP id j186so7217993pge.2
        for <linux-sparse@vger.kernel.org>; Tue, 11 Jul 2017 22:29:38 -0700 (PDT)
In-Reply-To: <CACXZuxerM5i33YgKn=GfnWQe+pViCUfUmJ10sz0K-+PjG28uwA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Jul 11, 2017 at 2:04 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> I think that duplicating a list because that list is being modified is
> quite a sensible thing to do. My only suggestion would be that perhaps
> you could have a dup() step that is separate so that you can use the
> normal iterator macro after duplicating.

So are you suggesting some thing like this:

struct ptr_list *dup_list = NULL:
concat_ptr_list(orign_list, &dup_list);
FOR_EACH_PTR(dup_list, ptr) {
...
} END_FOR_EACH_PTR(ptr);
free_ptr_list(dup_list);

I think that should work. But it come with a price
allocating and freeing the list (otherwise it is a memory leak).

Also run slightly slower. My current way will only duplicate
the list struct one at a time. It never duplicate the full list.
It has fixed memory usage, no allocating, no duplicate of
the ->next and ->prev pointer.

So what macro do you have in mind? I think any thing modify
the duplicate list does not make sense.

On thing I can do is rename the __list into __orig, then rename
__dup into __list. Then most of the list macro using __list should
work. It also means I have to use END_FOR_EACH_PTR_DUP()
as well.


Chris
