From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: sparse-llvm potential error in linearized output
Date: Sun, 12 Mar 2017 16:52:12 +0000
Message-ID: <CACXZuxf5CtaZj4uk1Rq+M3pys04F4OP7AOWPvDTEtV5JrM_udg@mail.gmail.com>
References: <CACXZuxfajgS=+3MEw-ECnsmnpZqu8WXLhjrvsfjkD1X-+dNxbw@mail.gmail.com>
 <CA+55aFzqZozMb0A4HMJ8UTNEV+LqHWXQsSBrPLMts_vkxsKtQA@mail.gmail.com>
 <CA+55aFxuovvof9UhSAnQMuBjEr0xd8qxbDSV1cpi_ubWx386Zg@mail.gmail.com> <CA+55aFyaW01tfG5LP+aeV-hSppzhqW7gCV7EM2OmxbJyg0cBXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35712 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933837AbdCLQwO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 12:52:14 -0400
Received: by mail-io0-f172.google.com with SMTP id z13so72717866iof.2
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 09:52:13 -0700 (PDT)
In-Reply-To: <CA+55aFyaW01tfG5LP+aeV-hSppzhqW7gCV7EM2OmxbJyg0cBXw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 12 March 2017 at 16:27, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mar 12, 2017 6:04 AM, "Dibyendu Majumdar" <mobile@majumdar.org.uk> wrote:
>         load.64     %r3 <- 0[randomletters]
>
>
> Looks fine to me.
>
> You have a variable called randomletters, and it's a pointer to a char. That
> 64-bit load just loads that pointer value from the variable into %r3.
>
> The sparse linearized format only has one memory access model: load with
> constant offset. The base can either be a symbol address (like in this case)
> or a register.
>

Ok thanks.

Regards
Dibyendu
