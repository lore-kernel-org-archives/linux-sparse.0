From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Reverting OP_SYMADDR in sparse-llvm
Date: Tue, 21 Mar 2017 13:10:22 +0100
Message-ID: <20170321121021.hdgii255tjuwodlj@macbook.local>
References: <CACXZuxdwK2QJzPOfP-QaLiWa5ow9oRHPA7=EpMEzkin6FrsfiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35478 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756497AbdCUMMC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 08:12:02 -0400
Received: by mail-wr0-f182.google.com with SMTP id g10so110676116wrg.2
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 05:10:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdwK2QJzPOfP-QaLiWa5ow9oRHPA7=EpMEzkin6FrsfiA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 21, 2017 at 10:59:47AM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> In the last two sets of patches I have noticed that you have reverted
> the change related to OP_SYMADDR. I would like to understand what fix
> in sparse-llvm made this change unnecessary.

Yes, I forgot to state that in the changelog.
 
It's not that it is now unnecessary but there are case where
it's wrong.

It's certainly one of the things I'll look further because
I think that it is better to have these SYMADDR.

-- Luc
