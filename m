From: Christopher Li <sparse@chrisli.org>
Subject: Re: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 08:34:31 -0400
Message-ID: <CANeU7QnGNxbNgM=sfBQ+qhNTJ70JuJ3bx1LAoDu-JNkJfTFtSg@mail.gmail.com>
References: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
 <CACXZuxdnMFA5HPg3GXLWXP6+Mk8+UikcZsJZH8DJ227PYHyEfQ@mail.gmail.com>
 <CANeU7Q=r4A8WQrqaACQ2iak9CcEXds20peJrr1AqJ8tyxCF56Q@mail.gmail.com> <CAMHZB6Eo++vHKYqn9JJUoqBnmER30+2Va27opCWR-CqE+V1HmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34955 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdHPMec (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:34:32 -0400
Received: by mail-yw0-f180.google.com with SMTP id l82so21501098ywc.2
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:34:32 -0700 (PDT)
In-Reply-To: <CAMHZB6Eo++vHKYqn9JJUoqBnmER30+2Va27opCWR-CqE+V1HmA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 8:33 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Aug 16, 2017 at 2:09 PM, Christopher Li <sparse@chrisli.org> wrote:
>>
>> Because the paper "simple and elegant" only cover the reducible
>> graph case. When you considering the irreducible graph source file
>> input, say having "goto", all the sudden it is not simple and elegant
>> any more. It is more like complex and ad-hoc.
>
> You mix two things together, Chris.
>
>> Exactly. I am totally agree with you. My worries are the hidden complexity
>> dealing with gotos in that paper.
>
> The code is there and running.

Ok, thanks for the clarification.

Chris
