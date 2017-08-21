From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Question about Sparse parsing - return statement
Date: Mon, 21 Aug 2017 16:42:43 -0700
Message-ID: <CA+55aFzKRP4uLQgGqhfT-hLCmm-f8ZHFyzwM-JtK4h0YJs93Zw@mail.gmail.com>
References: <CACXZuxc36un9_MM6T=iujCSoYuOVxtf=ZmtszVgmcHqj37DB+Q@mail.gmail.com>
 <CA+55aFzWEvVX-=Y0228qsZdVsFocs_dYT=Ds=i+x2RQ-yzGzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33032 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753790AbdHUXmo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 19:42:44 -0400
Received: by mail-oi0-f44.google.com with SMTP id f11so170278390oic.0
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 16:42:44 -0700 (PDT)
In-Reply-To: <CA+55aFzWEvVX-=Y0228qsZdVsFocs_dYT=Ds=i+x2RQ-yzGzTg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 4:40 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sparse uses symbols for branch targets too.

Side note: when you work with the linearized representation, I don't
think you should really need to care. You should be able to just work
with the basic block information, and the symbols that are used to
generate the branches between the basic blocks should be pretty much a
non-issue by the time it's all been linearized.

But maybe I'm missing or have forgotten something.

            Linus
