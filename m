From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix cgcc ELF version for ppc64/pcc64le
Date: Mon, 2 Oct 2017 21:45:07 +0200
Message-ID: <20171002194505.peltjzj5f7q6bbqr@ltop.local>
References: <20170927080007.jz2vfe4ekjjowkbe@taurus.defre.kleine-koenig.org>
 <20170927211137.16461-1-luc.vanoostenryck@gmail.com>
 <20170930084913.raksvxhqlceh6qgs@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33666 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdJBTpK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 2 Oct 2017 15:45:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id u138so3466623wmu.0
        for <linux-sparse@vger.kernel.org>; Mon, 02 Oct 2017 12:45:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170930084913.raksvxhqlceh6qgs@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Sat, Sep 30, 2017 at 10:49:13AM +0200, Uwe Kleine-König wrote:
> Hello Luc,
> 
> On Wed, Sep 27, 2017 at 11:11:37PM +0200, Luc Van Oostenryck wrote:
> > Commit e0306fe0 "cgcc: teach cgcc about ppc64[le]" add support
> > for PPC64 to cgcc by adding the needed options like '-m64' &
> > '-m{little,big}-endian' and defines likes '-D__PPC64__=1'.
> > 
> > In this commit the defined '-D_CALL_ELF=2' was also added
> > but the value of 2 is for ELF v2 ABI, normally used for ppc64le,
> > while the older ELF ABI, normally used for plain ppc64 should use
> > '-D_CALL_ELF=2'.
> > 
> > Fix this by using the value of 1 or 2 for '_CALL_ELF' depending
> > if the architecture is ppc64 or ppc64le.
> > 
> > Fixes: e0306fe0b725af6e2e7ff59d7f0d99c96315791a
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> I tested that patch on the following machines:
> 
> hostname/chroot                 uname -m        gcc -dumpmachine
> partch/sid                      ppc             powerpc-linux-gnu
> pizzetti/sid_ppc64-dchroot      ppc64           powerpc64-linux-gnu
> plummer/sid_ppc64el-dchroot     ppc64le         powerpc64le-linux-gnu
> 
> and my test case (env CHECK=./sparse ./cgcc -no-compile memops.c) works
> on all of them now.
> 
> Tested-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> Thanks
> Uwe

Many thanks for the testing.


@ Chris,

Can you take the patch as is or do you prefer that I send a pull request?

-- Luc
