From: Christopher Li <sparse@chrisli.org>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 00:02:07 -0400
Message-ID: <CANeU7QkPX30OHb_GLqDv=22YJ6aAY5KCe55=QJ17fbNaFqtFVA@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local> <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local> <CANeU7QmuZ1rWr08ZzGvyHDqmTvfgL9Abjzep2qWS3xQq7DL2XA@mail.gmail.com>
 <CAExDi1Qmv5iyZX2GQHa5jb7qTw+F8a3VmBXwBh+7EvpRfkQYtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:32913 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdIGECJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 00:02:09 -0400
Received: by mail-yw0-f176.google.com with SMTP id s62so11797393ywg.0
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 21:02:08 -0700 (PDT)
In-Reply-To: <CAExDi1Qmv5iyZX2GQHa5jb7qTw+F8a3VmBXwBh+7EvpRfkQYtQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Sep 6, 2017 at 11:46 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

>> For reducible graph that algorithm converge in constant iteration.
>
> Where the 'constant' is a function of the loop complexity (maximum
> nesting level) ...

I think we are talking different things.

My iteration means one pass of the reverse postorder.
In the Keith Cooper et al paper end of first page:
quote "
show that reverse postorder iterative scheme solves these
equations in a single pass over the CFG for reducible graphs.
"
page 2 reference 19 also mention solved in linear time
on reducible graphs.

It is just linear to the size of the CFG if graph is reducible.
I don't recall it is related to maximum nesting level of loops.

For the Simple SSA paper, maybe.

Chris
