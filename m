From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/6] storage should not be inherited by pointers
Date: Fri, 25 Nov 2016 10:09:25 +0800
Message-ID: <CANeU7QnGdG8x+1SzKP7e8f6Gan8VZh7MNMGpZ=E3JwSQ2xYkAw@mail.gmail.com>
References: <20161124170947.14379-1-luc.vanoostenryck@gmail.com> <20161124170947.14379-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36066 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbcKYCJ1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 21:09:27 -0500
Received: by mail-io0-f196.google.com with SMTP id k19so7318544iod.3
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 18:09:26 -0800 (PST)
In-Reply-To: <20161124170947.14379-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 25, 2016 at 1:09 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Information about storage is needed for objects but once
> you take the address of an object, its storage should be
> irrelevant for the resulting pointer.
>
> Trying to keep the storage into the pointer's modifiers
> (while it will be available in the base type anyway) only
> create corner cases later.

Either way it is going to be very tricky. If you make the pointer
does not inherent the object storage modifier, you need to change
all the place that assume the pointer will inherent the object storage.

Because C mostly deal with pointer, e.g. "a = b;", is actually
"*(&a) = *(&b);". Pointer is all over the place.  Right now sparse
make the pointer inherent the storage is convenient but not precise.
Changing the underlining assumption will touch a lot of code.

The extremely tricky one is the context and address space
store in "struct ctype". It is not a modifier but act like one.
Address space should belong to the storage object. But
right now address space is propagate to pointer as well.
Most of the test is done on pointer level.

> An example of the problem it can create is when the pointer
> is dereferenced in an inlined function.
>
> Better to simply not put have the storage informations
> for the pointer, which is what this patch does.

I think there will be other code changes associate with the assumption
change.

One thing to verify is if sparse issues different set of warning
on the Linux kernel check.

Chris
