From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse linear instruction offset for memops
Date: Sun, 12 Mar 2017 18:27:13 +0100
Message-ID: <20170312172712.nw7nsphvaqz44s2r@macpro.local>
References: <CACXZuxcS5c-QS-KzDjxMD6j5MVAJfKicDaKRR6V10NQTKqHLcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36551 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934461AbdCLR1l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 13:27:41 -0400
Received: by mail-wr0-f175.google.com with SMTP id u108so90863976wrb.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 10:27:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxcS5c-QS-KzDjxMD6j5MVAJfKicDaKRR6V10NQTKqHLcg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 12, 2017 at 02:46:18PM +0000, Dibyendu Majumdar wrote:
> Hi
> 
> I am investigating a crash in the avltree test program I mentioned
> before. I noticed the following:
> 
> Linearised output:
> 
>  load.64     %r338 <- -16[%r333]
> 
> LLVM output:
> 
>   %10 = getelementptr inbounds i8, i8* %9, i64 4294967280
> 
> Instead of -16 we are getting a garbage offset. This appears to be
> caused by the fact that the offset field in the instruction is
> unsigned. Should the offset be a signed field instead?

It's not the problem here, I think.
The LLVM instruction is an *inbound* GEP, so there is no reasons
to use a negative offset as it would automatically be out-of-bound.

The GEP is unappropriate here, the correct code should really
subtract the offset from the pointer and then use this as the
load address.

-- Luc Van Oostenryck
