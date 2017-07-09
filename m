From: Christopher Li <sparse@chrisli.org>
Subject: Re: Bug relate to delete ptr list entry while parent looping on it
Date: Sun, 9 Jul 2017 01:54:41 -0700
Message-ID: <CANeU7Q=8m=MbvXvoCfGucSEkTEzGyrd+Lr+-M3KenDCZb9s_-w@mail.gmail.com>
References: <CANeU7QnEnRiaLgYP-cLOgEJD1Hrc3aUMn7MrpjYJoGFjBzKUnA@mail.gmail.com>
 <20170709071845.qqjvyh75h4wxccfq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34852 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdGIIym (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 04:54:42 -0400
Received: by mail-pg0-f47.google.com with SMTP id j186so35527948pge.2
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 01:54:42 -0700 (PDT)
In-Reply-To: <20170709071845.qqjvyh75h4wxccfq@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Jul 9, 2017 at 12:18 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Jul 08, 2017 at 10:54:18PM -0700, Christopher Li wrote:
>> Hi Luc,
>>
>> I make some progress of the ptrlist ref count patch.
> Have you this new version available somewhere?

Just clean it up a bit:

https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=ptrlist-refcount-clean

While you where there, can you take a look at the patch before it?
I need to have it to avoid die on the ep->bbs list.
I will send out a different email for review.

Chris
