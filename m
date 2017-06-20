From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] dissect: use built_in_ident() instead of MK_IDENT()
Date: Tue, 20 Jun 2017 13:17:41 +0200
Message-ID: <20170620111740.GB21354@redhat.com>
References: <20170619211454.45244-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750985AbdFTLRn (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 07:17:43 -0400
Content-Disposition: inline
In-Reply-To: <20170619211454.45244-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Chris Li <sparse@chrisli.org>

On 06/19, Luc Van Oostenryck wrote:
>
> The motivation for this patch was to allow sparse to be
> compiled with clang which doesn't like what is done
> on VLAs in the MK_IDENT() macro.

could you spell please? I don't understand why clang can't compile this
code and I am just curious.

> But also, I can't see any justification for not using the
> real thing to create identifiers: built_in_ident().

Simply because MK_IDENT() is faster and simpler to use.

> CC: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  dissect.h      | 13 -------------
>  test-dissect.c |  6 +++---

iirc there should be another MK_IDENT user in dissect.c?

Oleg.

