From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sun, 12 Mar 2017 02:35:21 +0000
Message-ID: <CACXZuxczJH_wDHdwwENNmkUECsqO+7+PPzy6PUpw+B=rW0SiFg@mail.gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com> <20170311114903.zrhufw6ydneky3ya@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36353 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755500AbdCLCfX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 21:35:23 -0500
Received: by mail-io0-f182.google.com with SMTP id l7so67870977ioe.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 18:35:22 -0800 (PST)
In-Reply-To: <20170311114903.zrhufw6ydneky3ya@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On 11 March 2017 at 11:49, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sat, Mar 11, 2017 at 11:12:20AM +0000, Dibyendu Majumdar wrote:
>> I have been trying to compile a smallish program (AVL Tree
>> implementation) - making progress but it still fails to compile, so I
>> will report the next issue!
>
> Good.
>

Sadly it crashes when run using lli.

You can see the test programs I am using here:

https://github.com/dibyendumajumdar/dmr_c/tree/master/tests

I do not have driver scripts yet - but the README identifies the
programs that fail.

Regards
Dibyendu
