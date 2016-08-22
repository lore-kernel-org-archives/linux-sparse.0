From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Question regarding anotation
Date: Mon, 22 Aug 2016 17:25:50 +0000
Message-ID: <20160822172550.GA28401@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.osadl.at ([92.243.35.153]:43958 "EHLO mail.osadl.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754256AbcHVRdJ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Aug 2016 13:33:09 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Hi !

 A probably very basic sparse question - but I could not figure out a
 satisfying answer. while compile testing a patch for ntb_transfer.c I got

  CHECK   drivers/ntb/ntb_transport.c
drivers/ntb/ntb_transport.c:1583:43: warning: incorrect type in argument 1 (different address spaces)
drivers/ntb/ntb_transport.c:1583:43:    expected void *dst
drivers/ntb/ntb_transport.c:1583:43:    got void [noderef] <asn:2>*offset
drivers/ntb/ntb_transport.c:1583:56: warning: incorrect type in argument 2 (different address spaces)
drivers/ntb/ntb_transport.c:1583:56:    expected void const [noderef] <asn:1>*src
drivers/ntb/ntb_transport.c:1583:56:    got void *buf

 looking at the offending line;

static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
{
#ifdef ARCH_HAS_NOCACHE_UACCESS
        /*
         * Using non-temporal mov to improve performance on non-cached
         * writes, even though we aren't actually copying from user space.
         */
        __copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);

 the absence of a __user in the buf argument seems intentional and the
 dst is not a kernel but __iomem address which triggers the second warning
 So the first warning seems to be a false positive here, the second one
 Im not clear about, but I guess its also a false positive. The question
 is if there is a clean way to anotate this to make sparse happy without 
 any unwanted sideffects ?

 For the first warning using  (void __user *) entry->buf  should do
 and be side-effect free, but how could the second warning be fixed ?

 sparse message is from 4.8.0-rc2 (localversion-next is -next-20160822)
 sparse version is v0.5.0-44

thx!
hofrat
