From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse parsing question - iterator statements
Date: Tue, 22 Aug 2017 10:43:09 -0400
Message-ID: <CANeU7Qk6gOS8u-AZy3rujav=z-TiVf69HXNX4jL2b6FFLaxfNg@mail.gmail.com>
References: <CACXZuxfWQHzHs1gps6SPPKvX53HUwVfEeca=sJPatKg39GF-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33407 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932913AbdHVOnL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Aug 2017 10:43:11 -0400
Received: by mail-yw0-f173.google.com with SMTP id h127so40871262ywf.0
        for <linux-sparse@vger.kernel.org>; Tue, 22 Aug 2017 07:43:11 -0700 (PDT)
In-Reply-To: <CACXZuxfWQHzHs1gps6SPPKvX53HUwVfEeca=sJPatKg39GF-8w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 22, 2017 at 9:59 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I am trying to understand the way the iterator statement works. I
> think if I understand this correctly then there are some implicit
> jumps on pre-condition and post-condition - similar to the implicit
> jumps in if statements. What I mean by that is that the parse tree
> does not model these jumps with explicit gotos.

The jump back to the loop beginning that goto was implicit.
The rest is just pre_condition and post_condition expression.
It is similar to this:

while (1) {
       if (!pre_condtion())
                break;

       iterator_statement();

       if (!post_condition())
                break;
}


Chris
