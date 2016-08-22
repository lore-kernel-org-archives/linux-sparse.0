From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Question regarding anotation
Date: Mon, 22 Aug 2016 23:02:23 +0200
Message-ID: <20160822210221.GA34545@macbook.home>
References: <20160822172550.GA28401@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36693 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbcHVVC7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Aug 2016 17:02:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so15179279wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 22 Aug 2016 14:02:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160822172550.GA28401@osadl.at>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: linux-sparse@vger.kernel.org

On Mon, Aug 22, 2016 at 05:25:50PM +0000, Nicholas Mc Guire wrote:
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

So the original code, now in the #else part was:
	memcpy_toio(offset, entry->buf, entry->len);
which is correct regarding the annotation/extended typing:
	- offset points to IO memory (annotated as void __iomem *)
	- entry->buff is normal kernel memory (no annotation needed)

I have no idea if replacing this by __copy_from_user_inatomic_nocache()
does indeed improve performance or not, but it's a complete abuse of this
function's typing and intent and sparse rightfully complains about both case.

So, I really think that these warnings don't need any fixing and that hiding
them behind a cast is not a good idea at all.
Independently of the validity of using __copy_from_user_inatomic_nocache()
here it would be much better to have something like memcpy_toio_nocache().
Doesn't something like this already exist?
Why not make something using the primitives already used by 
__copy_from_user_inatomic_nocache() (where, if really needed, using a cast
to "adjust" the types is much more justified)?


Regards,
Luc Van Oostenryck
