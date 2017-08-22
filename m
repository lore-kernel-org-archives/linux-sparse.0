From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse parsing question - iterator statements
Date: Tue, 22 Aug 2017 15:51:19 +0100
Message-ID: <CACXZuxdKSnt0SW=vS0w=c7WUkFKSV7F8kn6WZQJo+6dXz1vtbA@mail.gmail.com>
References: <CACXZuxfWQHzHs1gps6SPPKvX53HUwVfEeca=sJPatKg39GF-8w@mail.gmail.com>
 <CANeU7Qk6gOS8u-AZy3rujav=z-TiVf69HXNX4jL2b6FFLaxfNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33068 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbdHVOvU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Aug 2017 10:51:20 -0400
Received: by mail-vk0-f54.google.com with SMTP id j189so59962259vka.0
        for <linux-sparse@vger.kernel.org>; Tue, 22 Aug 2017 07:51:20 -0700 (PDT)
In-Reply-To: <CANeU7Qk6gOS8u-AZy3rujav=z-TiVf69HXNX4jL2b6FFLaxfNg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 22 August 2017 at 15:43, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Aug 22, 2017 at 9:59 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> I am trying to understand the way the iterator statement works. I
>> think if I understand this correctly then there are some implicit
>> jumps on pre-condition and post-condition - similar to the implicit
>> jumps in if statements. What I mean by that is that the parse tree
>> does not model these jumps with explicit gotos.
>
> The jump back to the loop beginning that goto was implicit.
> The rest is just pre_condition and post_condition expression.
> It is similar to this:
>
> while (1) {
>        if (!pre_condtion())
>                 break;

Except that the if (!) / break is implicit?

>
>        iterator_statement();
>
>        if (!post_condition())
>                 break;

And here too?

> }
>

Thanks and Regards
Dibyendu
