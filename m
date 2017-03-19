From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 00/30] LLVM fixes
Date: Sun, 19 Mar 2017 09:28:31 -0700
Message-ID: <CANeU7Q=LVUz35hFxdfDUp+vza=xwJP=SHx5F1ApUsLeWLqRraw@mail.gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:35010 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdCSQ2d (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 12:28:33 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so10437314itc.0
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 09:28:32 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Mar 18, 2017 at 6:41 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series solves a number of issues in sparse-llvm,
> mainly about wrong or missing type information as needed
> to build LLVM IR.
> Most of these issues have been reported and investigated by
> Dibyendu Majumdar.


Thanks for the patches.

I will take a look and try it on sparse-next.

Chris
