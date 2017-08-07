From: Christopher Li <sparse@chrisli.org>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Mon, 7 Aug 2017 11:19:40 -0400
Message-ID: <CANeU7QmHw64LL7Ke-JrN5O1EmU8uKXg9V1REswFUKZToRG75uw@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36686 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdHGPTl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 11:19:41 -0400
Received: by mail-pg0-f51.google.com with SMTP id v77so2822493pgb.3
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 08:19:41 -0700 (PDT)
In-Reply-To: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 11:11 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I would like to understand the structure of the parse tree generated
> by Sparse a bit better. I am looking at the output from the show_*()
> functions but it is not clear to me exactly what the output means. For
> example:

You can try test-inspect, it will pop up a gtk window which
you can click on the object and expand the object members.

It is not complete but it is very easy to extend.

Chris
