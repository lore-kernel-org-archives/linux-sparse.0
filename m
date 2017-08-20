From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: SSSA and some C pointer manipulation.
Date: Sun, 20 Aug 2017 02:08:09 +0200
Message-ID: <CAMHZB6EqBouFuAMy+Nvr=XAJqxZBGgrRSzsz=zbhv-yQ6zLJtg@mail.gmail.com>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
 <CACXZuxdO+pco93WYtbh4W95c6r+f9fp_85TFhQvn-8UOQvOBWw@mail.gmail.com>
 <CANeU7Q=x_DZzp93jP9AU5zpTuggR1AGa9pYqwi-kitXV5EKs0w@mail.gmail.com> <CACXZuxf-yb5WODCDJ2cQxJ2_sKUwSeKwAmOX+GHCWpd0qOvGvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:35275 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752467AbdHTAIK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 19 Aug 2017 20:08:10 -0400
Received: by mail-ua0-f177.google.com with SMTP id q42so25398447uad.2
        for <linux-sparse@vger.kernel.org>; Sat, 19 Aug 2017 17:08:10 -0700 (PDT)
In-Reply-To: <CACXZuxf-yb5WODCDJ2cQxJ2_sKUwSeKwAmOX+GHCWpd0qOvGvQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 19, 2017 at 1:57 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Yes. I have a growing set of tests but I only check the final result
> is correct - i.e. the code can be run (both with and without
> simplifications) and will produce expected results.

While I'm all in favour of such tests, I also think that at the current
stage of sparse's development, such tests are not what we
need because:
1) to be able to run/execute the code you need a whole machinery
    we don't have yet
2) they are dependent on implementation details, kinda architecture/
    machine specific
3) they are dependent on the correctness of the backend used
4) they are dependent on run-time support (like printf()
    implementation, for example.
4) they don't help at all to debug

So, this kind of tests makes a lot of sense to you because you're
developing a backend. They will certainly be useful later if/when
sparse will have a backend. But currently, small, specific, more
unit-like tests are much more useful to me.

-- Luc
