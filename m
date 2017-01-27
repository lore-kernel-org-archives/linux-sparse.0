From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Output from linearize and LLVM error
Date: Fri, 27 Jan 2017 14:29:55 +0000
Message-ID: <CACXZuxfFH+U2oFkQYauZjanp_caLb70ki6A0U-4Qy7n9S7H2Hg@mail.gmail.com>
References: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35416 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754740AbdA0OaC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 09:30:02 -0500
Received: by mail-ua0-f169.google.com with SMTP id y9so207288986uae.2
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 06:29:56 -0800 (PST)
In-Reply-To: <CACXZuxdM0zwfubUxHTJDen456-y9cpgpQJBcB8gKoXYtX5baSA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On 27 January 2017 at 14:00, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
>         foo *p = (foo *) malloc(sizeof(struct foo));

> There were two failures. First one occurs in the result of the
> sizeof() expression - it seems the builder tries to create an integer
> constant but passes LLVM a 'char *' as the type, which causes an
> assertion failure in LLVM. This error occurs in pseudo_to_value()
> function in sparse-llvm.c for the case PSEUDO_VAL. I worked around
> this by checking if the type is a pointer and then asking LLVM to
> create an integer constant of appropriate size (not sure why the type
> is a pointer type here).
>

It seems that the sparse-llvm code is using the symbol associated with
the instruction to work out the type of the PSEUDO_VAL which is
incorrect? From what I can see PSEUDO_VAL is just an integer constant
- is there a type associated with it?

Thanks and Regards
Dibyendu
