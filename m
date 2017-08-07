From: Christopher Li <sparse@chrisli.org>
Subject: Re: Best way to inspect the parse tree from Sparse
Date: Mon, 7 Aug 2017 19:35:39 -0400
Message-ID: <CANeU7Qm3JuMq_0OMiNxgcLKMkO8rhLNcWF3yeXqORZPpbvLUmg@mail.gmail.com>
References: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
 <20170807184653.a6xtjfbutnsnecnf@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35821 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbdHGXfk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 19:35:40 -0400
Received: by mail-pg0-f43.google.com with SMTP id v189so7349333pgd.2
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 16:35:40 -0700 (PDT)
In-Reply-To: <20170807184653.a6xtjfbutnsnecnf@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 2:46 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> I only tried it a few time and it wasn't at all helping me.
> The parsing tree is all about the statements and the expressions,
> so I always end to look directly at the code.
> I dunno about the inspect & dissect tools.

The test-inspect knows about statements and expressions. You
just need to expand the right object.

Chris
