From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Question regarding anotation
Date: Mon, 22 Aug 2016 15:01:15 -0700
Message-ID: <CA+55aFyJ7Xmfbe4MOVdq8OOq77y+iTZD9XHAPR0_K-fVOF2t=w@mail.gmail.com>
References: <20160822172550.GA28401@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35806 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932497AbcHVWBV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Aug 2016 18:01:21 -0400
Received: by mail-oi0-f49.google.com with SMTP id 4so171977528oih.2
        for <linux-sparse@vger.kernel.org>; Mon, 22 Aug 2016 15:01:21 -0700 (PDT)
In-Reply-To: <20160822172550.GA28401@osadl.at>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Aug 22, 2016 at 10:25 AM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
>  A probably very basic sparse question - but I could not figure out a
>  satisfying answer. while compile testing a patch for ntb_transfer.c I got
>
>   CHECK   drivers/ntb/ntb_transport.c
> drivers/ntb/ntb_transport.c:1583:43: warning: incorrect type in argument 1 (different address spaces)
> drivers/ntb/ntb_transport.c:1583:43:    expected void *dst
> drivers/ntb/ntb_transport.c:1583:43:    got void [noderef] <asn:2>*offset
> drivers/ntb/ntb_transport.c:1583:56: warning: incorrect type in argument 2 (different address spaces)
> drivers/ntb/ntb_transport.c:1583:56:    expected void const [noderef] <asn:1>*src
> drivers/ntb/ntb_transport.c:1583:56:    got void *buf

Yes, sparse is correcy, and the ntb code is doing some really dodgy
things that may or may not actually work. In fact, they are pretty
much guaranteed to not work on some architectures.

Playing games with nontemporal stores is almost always a bug anyway. Ugly, ugly.

             Linus
