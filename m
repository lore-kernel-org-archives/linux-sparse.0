From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 06/13] llvm: fix type of literal integer passed as arguments
Date: Fri, 10 Mar 2017 18:47:08 +0100
Message-ID: <CAExDi1TUVG3mj556ugT_qdubBRJfVXo0qmAnhWdo5Y33q4p1Pw@mail.gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
 <20170305112047.3411-7-luc.vanoostenryck@gmail.com> <CANeU7Qnoqg-rM2MS+3BuKEvsLUBvnv+rvfYmE=XkhMicdejN=A@mail.gmail.com>
 <CACXZuxeTUqXuBd+42SGFB5sLDirea1q2WnG8s=SqcU+DAd1-3Q@mail.gmail.com> <CACXZuxdyT9LWejONpYi0rg7hr+xoVgdS-Wy_6OhSps_RL8idZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32992 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdCJRrK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Mar 2017 12:47:10 -0500
Received: by mail-qk0-f180.google.com with SMTP id y76so178939150qkb.0
        for <linux-sparse@vger.kernel.org>; Fri, 10 Mar 2017 09:47:09 -0800 (PST)
In-Reply-To: <CACXZuxdyT9LWejONpYi0rg7hr+xoVgdS-Wy_6OhSps_RL8idZw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Mar 10, 2017 at 5:08 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> I have also hit a problem when calling a function via function
> pointer. In this case the instruction->func appears to be PSEUDO_REG
> rather than PSEUDO_SYM, so trying to get the function prototype
> doesn't work.
>
> If the call is a via a function pointer then where should one look for
> what the argument type should be when a constant is encountered?

I think I have all such cases fixed.
I'll send an updated patch serie later today or tomorrow.

Luc
