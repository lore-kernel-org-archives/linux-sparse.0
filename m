From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v6 00/52] LLVM fixes
Date: Fri, 31 Mar 2017 13:28:26 +0800
Message-ID: <CANeU7QnNAHbE3fto09=2jsDS2vnNscA9sieG263=ck8LZ6j6Kw@mail.gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33974 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdCaF22 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 01:28:28 -0400
Received: by mail-io0-f169.google.com with SMTP id b140so33316109iof.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 22:28:27 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 5:23 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series solves a number of issues in sparse-llvm,
> mainly about wrong or missing type information as needed
> to build LLVM IR.
> Most of these issues have been reported and investigated by
> Dibyendu Majumdar.
>
> Changes since v5:
> - avoid declare a var inside a for-loop for non C99 compilers
> - fix naming of symbol without an indent
> - avoid sparsec to leave its tmp file
>
> Changes since v4:
> - extract the non sparse-llvm specific patches into
>   a separate, preparatory serie.

V4 has 63 patches. V5 has 51 and V6 has 52 patches.

I assume I just drop the 63 patches in V4 and use the 52 patches instead?

Chris
