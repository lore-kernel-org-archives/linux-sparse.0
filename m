From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] normalize bb's label names for testing
Date: Wed, 23 Nov 2016 00:44:36 +0800
Message-ID: <CANeU7Qk+_N7A+DMKrLxoNi1fq8twfpJ8jLeartsc+jsMQiXN0Q@mail.gmail.com>
References: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=uNLQh=ynnWPeO0+ahu7qhJ2nxqxOrxbDraR1jo6xEAQ@mail.gmail.com> <20161122132748.GB8370@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33010 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755432AbcKVQok (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 11:44:40 -0500
Received: by mail-io0-f193.google.com with SMTP id j92so11581616ioi.0
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 08:44:37 -0800 (PST)
In-Reply-To: <20161122132748.GB8370@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Nov 22, 2016 at 9:27 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Absolutely. It's what I'm doing here on my working tree.
>

Great.

> The problem with this 'priv' is that it's, well ... private, if we
> reuse it to store labels IDs it possibly can't be used anymore for
> this private usage.
> I would be more tempted to reuse the 'generation' field which is a long
> and don't need much bits.
> Of course, the real question is if that's such important to not add a new
> field to struct bb.

It is private to the back end. If you consider test-linearize as one of
the back end, it compile the C code into readable text form. it is fine
to use it. I assume the label ID is only make sense for test-linearize,
not for other back end?

I am also OK with just introduce one more field ID for basic blocks.
There are far less basic blocks than instructions. So even size of basic
block bump up by a integer is not a big deal.

> Sure.
> But it should be noted that this filtering stuff *could* be useful for other
> things to (but I have no such uses).

We can always deal with it when such usage actually come up.

Chris
