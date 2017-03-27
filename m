From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v6 00/15] prepare for LLVM fixes
Date: Tue, 28 Mar 2017 00:22:13 +0200
Message-ID: <20170327222212.jle5tzjevfsigvuw@macpro.local>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
 <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36791 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbdC0WWR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 18:22:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id u1so17436406wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 15:22:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7406f777-5e8b-5ae0-55e0-26a36ddb64b5@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Mon, Mar 27, 2017 at 10:56:52PM +0100, Ramsay Jones wrote:
> 
> 
> On 27/03/17 18:33, Luc Van Oostenryck wrote:
> > This serie contains preparatory patches for
> > sparse-llvm's fixes but not sparse-llvm specific
> > and having some values of their own.
> > 
> > These patches were extracted from a previous
> > serie containing also the sparse-llvm patches.
> > 
> > Changes since v5:
> > - use a table for compare_opcode() & swap_compare_opcode()
> > - fix test cases on 32bit machines
> 
> Hmm, I assumed that this series should apply to master, and then
> the following 52 patch series on top.

Well no, sorry.
I haven't explained because I thought it was obvious but
of course, it's not obvious at all.

These series apply, and in general any patches or series I send,
in the order I send them, on top of the stable part of sparse-next.
And by "the stable part of sparse-next" I mean that if sparse-next
contains serie-xyz-v2 and I sent serie-xyz-v3, the serie will apply
at the same place that the -v2 serie was.

It's a time somehow painfull, I agree. It's why I try also push
the serie on github when the serie is worth of it (and complete).
in this case you can find everything at:
	https://github.com/lucvoo/sparse/commits/llvm-fixes-v6

(and yes, this tree contains a few more patches, not in the serie
already submitted but not yet in sparse-next).

Sorry for any lost of time.

-- Luc
