From: Van Oostenryck Luc <luc.vanoostenryck@gmail.com>
Subject: Re: Question regarding anotation
Date: Mon, 22 Aug 2016 22:00:26 +0200
Message-ID: <CAExDi1Sa9p1HAx=Og-yaoMSoP0kROEK0egz5Ocg-+w=WabVb6A@mail.gmail.com>
References: <20160822172550.GA28401@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34694 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756184AbcHVUAb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Aug 2016 16:00:31 -0400
Received: by mail-qt0-f194.google.com with SMTP id c52so3134222qte.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Aug 2016 13:00:28 -0700 (PDT)
In-Reply-To: <20160822172550.GA28401@osadl.at>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: linux-sparse@vger.kernel.org

Hi,

So, the original code that is now part of the #else part was:
memcpy_toio(offset, entry->buf, entry->len);

On Mon, Aug 22, 2016 at 7:25 PM, Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
> Hi !
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
>
>  looking at the offending line;
>
> static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> {
> #ifdef ARCH_HAS_NOCACHE_UACCESS
>         /*
>          * Using non-temporal mov to improve performance on non-cached
>          * writes, even though we aren't actually copying from user space.
>          */
>         __copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
>
>  the absence of a __user in the buf argument seems intentional and the
>  dst is not a kernel but __iomem address which triggers the second warning
>  So the first warning seems to be a false positive here, the second one
>  Im not clear about, but I guess its also a false positive. The question
>  is if there is a clean way to anotate this to make sparse happy without
>  any unwanted sideffects ?
>
>  For the first warning using  (void __user *) entry->buf  should do
>  and be side-effect free, but how could the second warning be fixed ?
>
>  sparse message is from 4.8.0-rc2 (localversion-next is -next-20160822)
>  sparse version is v0.5.0-44
>
> thx!
> hofrat
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
