From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Query: clarification of a comment in linearize.c
Date: Fri, 11 Aug 2017 00:37:15 +0200
Message-ID: <CAExDi1QX1n5wQWfOpGvGg_CaEq0XO9Hi6z6wvrE0K2uQJoWGMw@mail.gmail.com>
References: <CACXZuxc24O=0aw0b5UPHBt3Dh202smLZZPS5gm4obOV_BdQ4eA@mail.gmail.com>
 <CANeU7QmsJhScTd0ZBMcRnv8wZ8VeruGEOC25+NGS_Yg8x6ewnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35557 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbdHJWhQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 18:37:16 -0400
Received: by mail-oi0-f50.google.com with SMTP id e124so19975279oig.2
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 15:37:16 -0700 (PDT)
In-Reply-To: <CANeU7QmsJhScTd0ZBMcRnv8wZ8VeruGEOC25+NGS_Yg8x6ewnA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 8:29 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Aug 10, 2017 at 2:19 PM, Dibyendu Majumdar wrote:
>>
>> Is this statement still true - i.e. only statements are linearized?
>
> Of course not.

Absolutely.
The linearized code has *all* what I would call the operational information
of the source code. This includes, of course, the expressions.

The comment should be removed.

-- Luc
