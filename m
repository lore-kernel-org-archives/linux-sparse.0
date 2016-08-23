From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: Question regarding anotation
Date: Tue, 23 Aug 2016 08:58:28 +0000
Message-ID: <20160823085828.GB30833@osadl.at>
References: <20160822172550.GA28401@osadl.at>
 <20160822210221.GA34545@macbook.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.osadl.at ([92.243.35.153]:44263 "EHLO mail.osadl.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932973AbcHWI6w (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 23 Aug 2016 04:58:52 -0400
Content-Disposition: inline
In-Reply-To: <20160822210221.GA34545@macbook.home>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Aug 22, 2016 at 11:02:23PM +0200, Luc Van Oostenryck wrote:
> On Mon, Aug 22, 2016 at 05:25:50PM +0000, Nicholas Mc Guire wrote:
> > 
> > Hi !
> > 
> >  A probably very basic sparse question - but I could not figure out a
> >  satisfying answer. while compile testing a patch for ntb_transfer.c I got
> > 
> >   CHECK   drivers/ntb/ntb_transport.c
> > drivers/ntb/ntb_transport.c:1583:43: warning: incorrect type in argument 1 (different address spaces)
> > drivers/ntb/ntb_transport.c:1583:43:    expected void *dst
> > drivers/ntb/ntb_transport.c:1583:43:    got void [noderef] <asn:2>*offset
> > drivers/ntb/ntb_transport.c:1583:56: warning: incorrect type in argument 2 (different address spaces)
> > drivers/ntb/ntb_transport.c:1583:56:    expected void const [noderef] <asn:1>*src
> > drivers/ntb/ntb_transport.c:1583:56:    got void *buf
> > 
> >  looking at the offending line;
> > 
> > static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> > {
> > #ifdef ARCH_HAS_NOCACHE_UACCESS
> >         /*
> >          * Using non-temporal mov to improve performance on non-cached
> >          * writes, even though we aren't actually copying from user space.
> >          */
> >         __copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
> > 
> >  the absence of a __user in the buf argument seems intentional and the
> >  dst is not a kernel but __iomem address which triggers the second warning
> >  So the first warning seems to be a false positive here, the second one
> >  Im not clear about, but I guess its also a false positive. The question
> >  is if there is a clean way to anotate this to make sparse happy without 
> >  any unwanted sideffects ?
> > 
> >  For the first warning using  (void __user *) entry->buf  should do
> >  and be side-effect free, but how could the second warning be fixed ?
> 
> So the original code, now in the #else part was:
> 	memcpy_toio(offset, entry->buf, entry->len);
> which is correct regarding the annotation/extended typing:
> 	- offset points to IO memory (annotated as void __iomem *)

but memcpy_toio() also will discard this anotation - atleast on x86
its using (void __force *)dst to "fix" this

> 	- entry->buff is normal kernel memory (no annotation needed)
> 
> I have no idea if replacing this by __copy_from_user_inatomic_nocache()
> does indeed improve performance or not, but it's a complete abuse of this
> function's typing and intent and sparse rightfully complains about both case.
> 
> So, I really think that these warnings don't need any fixing and that hiding
> them behind a cast is not a good idea at all.
> Independently of the validity of using __copy_from_user_inatomic_nocache()
> here it would be much better to have something like memcpy_toio_nocache().
> Doesn't something like this already exist?
> Why not make something using the primitives already used by 
> __copy_from_user_inatomic_nocache() (where, if really needed, using a cast
> to "adjust" the types is much more justified)?
>
users in 4.8,0-rc2 are:

i915_gem.c:i915_gem_phys_pwrite() - correct usage
pmem.h:arch_memcpy_to_pmem() "We are copying between two kernel buffer " 
         and "fixes" it with a (void __user *) cast
i915_gem.c:fast_user_write() - "We can use the cpu mem copy function because 
         this is X86. " (using (void __force*) to make sparse happy)
qxl_ioctl.c:qxl_process_single_command() - which produces sparse warning and 
         seems to be abusing this interface as well
ntb_transport.c:ntb_memcpy_tx() - which is the case at hand

Of the 5 users 1 is using it as intended and 4 are abusing the
interface more or less or making assumptions - i915_gem.c:fast_user_write()
is atleats documented and may be ok. pmem.h is x86 specific so might also
be ok. So pmem and the second i915_gem case probably would need a x86
specific memcpy_nocache() or so... 

And the use in qxl_ioctl/ntb_transport simply seem to be wrong - atleast I
se no reason why this should be x86 only code.

Anyway thanks for you clarifications - given the abuse rate in this
interface it really was hard to make much sense of this all on my own.

thx!
hofrat
