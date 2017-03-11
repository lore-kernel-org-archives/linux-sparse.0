From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 11:12:20 +0000
Message-ID: <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33189 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755038AbdCKLMW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 06:12:22 -0500
Received: by mail-io0-f173.google.com with SMTP id f84so60981513ioj.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 03:12:21 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

Hi Luc,

On 11 March 2017 at 09:06, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series solves a number of issues in sparse-llvm,
> mainly about wrong or missing type information as needed
> to build LLVM IR.
> These issues have been reported and investigated by
> Dibyendu Majumdar.
>
> * patches 1-4 adds missing type info in sparse's IR
> * patch   4 is not needed by this serie but logically belong
>           to the same group as patches 1-3. It can be dropped.
> * patches 5-7 are fixes
> * patch   8 makes debugging easier
> * patches 8-10 are preparatory steps for patch 11
> * patches 11 & 12 are fixes
> * patch   13 is a preparatory step for patch 14
> * patch   14 solves a lot of issues
> * patches 15-18 are test cases solved by patch 14
> * patch   19 & 20 are fixes
> * patches 21, 23-27 are cleanups
> * patch   22 makes debugging easier
>
>

Thank you very much for this series of patches. I have merged them
into my project and things are better. We still cannot invoke
functions via pointers to functions using the (*ident)(arg) syntax due
to the incorrect load operation output by the linearizer.

I have been trying to compile a smallish program (AVL Tree
implementation) - making progress but it still fails to compile, so I
will report the next issue!

Thanks and Regards
Dibyendu
