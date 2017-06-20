From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] dissect: use built_in_ident() instead of MK_IDENT()
Date: Tue, 20 Jun 2017 18:56:33 +0200
Message-ID: <20170620165633.GA26352@redhat.com>
References: <20170619211454.45244-1-luc.vanoostenryck@gmail.com>
 <20170620111740.GB21354@redhat.com>
 <20170620125345.nlchvizgz5ar5yrn@ltop.local>
 <20170620160711.GA23849@redhat.com>
 <20170620163950.gkdezvohrcz7okoo@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdFTQ4f (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 12:56:35 -0400
Content-Disposition: inline
In-Reply-To: <20170620163950.gkdezvohrcz7okoo@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Chris Li <sparse@chrisli.org>

On 06/20, Luc Van Oostenryck wrote:
>
> On Tue, Jun 20, 2017 at 06:07:11PM +0200, Oleg Nesterov wrote:
> > Hmm. Now that I git-cloned the code I understand. And I can't recall why MK_IDENT() was
> > written this way, it simply doesn't look right.
>
> It looks to me as you simply wanted to avoid doing dynamic allocation
> and/or the cost of the hashing.

This is clear ;) what is not clear is why I didn't do, say,

	#define	MK_IDENT(s)	({				\
		static struct {					\
			struct ident ident;			\
			char name[sizeof(s)];			\
		} ident = {					\
			.ident.len  = sizeof(s)-1,		\
			.name = s,				\
		};						\
		&ident.ident;					\
	})

probably because I wanted to avoid __attribute__((packed)) in struct ident,
not sure.

> > Probably can be fixed but I agree, lets
> > remove it.
>
> Probably yes, but yes btter to remove it.

Agreed.

Oleg.

