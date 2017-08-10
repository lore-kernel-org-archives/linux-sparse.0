From: Christopher Li <sparse@chrisli.org>
Subject: Re: Query: clarification of a comment in linearize.c
Date: Thu, 10 Aug 2017 14:29:07 -0400
Message-ID: <CANeU7QmsJhScTd0ZBMcRnv8wZ8VeruGEOC25+NGS_Yg8x6ewnA@mail.gmail.com>
References: <CACXZuxc24O=0aw0b5UPHBt3Dh202smLZZPS5gm4obOV_BdQ4eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36278 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdHJS3I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 14:29:08 -0400
Received: by mail-yw0-f174.google.com with SMTP id u207so9821349ywc.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 11:29:08 -0700 (PDT)
In-Reply-To: <CACXZuxc24O=0aw0b5UPHBt3Dh202smLZZPS5gm4obOV_BdQ4eA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 2:19 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I see following comment in linearize.c:
>
> * Linearize - walk the statement tree (but _not_ the expressions)
> * to generate a linear version of it and the basic blocks.
> *
> * NOTE! We're not interested in the actual sub-expressions yet,
> * even though they can generate conditional branches and
> * subroutine calls. That's all "local" behaviour.
>
> Is this statement still true - i.e. only statements are linearized?

Of course not. I think it was true at some point in the past.
We are way beyond that now.

One thing with the comments are, they don't get updated as timely
as the code get updated.

Chris
