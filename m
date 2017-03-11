From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 12:49:03 +0100
Message-ID: <20170311114903.zrhufw6ydneky3ya@macbook.local>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36546 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755108AbdCKLtI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 06:49:08 -0500
Received: by mail-wr0-f179.google.com with SMTP id u108so78599567wrb.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 03:49:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On Sat, Mar 11, 2017 at 11:12:20AM +0000, Dibyendu Majumdar wrote:
> We still cannot invoke
> functions via pointers to functions using the (*ident)(arg) syntax due
> to the incorrect load operation output by the linearizer.

Yes, I'm working on it.

> I have been trying to compile a smallish program (AVL Tree
> implementation) - making progress but it still fails to compile, so I
> will report the next issue!

Good. 

-- Luc Van Oostenryck
