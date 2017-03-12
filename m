From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm error in GEP offset
Date: Sun, 12 Mar 2017 18:31:08 +0100
Message-ID: <20170312173108.2kcar7zterlgu7rj@macpro.local>
References: <CACXZuxd=VaN_vi_+XkR1EuLgcc3QY4TQ9_vzsG-pCK_2r1=21g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33356 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934545AbdCLRbM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 13:31:12 -0400
Received: by mail-wr0-f173.google.com with SMTP id u48so91104884wrc.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 10:31:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxd=VaN_vi_+XkR1EuLgcc3QY4TQ9_vzsG-pCK_2r1=21g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 12, 2017 at 03:01:23PM +0000, Dibyendu Majumdar wrote:
> Hi,
> 
> The memops offset field in sparse linearized instruction is unsigned,
> which is causing invalid memory access in sparse-llvm. A workaround
> for this is to cast the offset to int in calc_memop_addr() function in
> sparse-llvm:
> 
>  off = LLVMConstInt(int_type, (int) insn->offset, 0);
> 
> However, perhaps the offset should not be unsigned in the first place.

I think so, yes.

-- Luc 
