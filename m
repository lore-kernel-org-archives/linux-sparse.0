From: Christopher Li <sparse@chrisli.org>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 00:33:32 -0400
Message-ID: <CANeU7Q=YQaXAVJw19zvLC4ueEw-R4bX5Uh0wc8C8ai2LfjSBFQ@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local> <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local> <CANeU7QmuZ1rWr08ZzGvyHDqmTvfgL9Abjzep2qWS3xQq7DL2XA@mail.gmail.com>
 <CAExDi1Qmv5iyZX2GQHa5jb7qTw+F8a3VmBXwBh+7EvpRfkQYtQ@mail.gmail.com>
 <CANeU7QkPX30OHb_GLqDv=22YJ6aAY5KCe55=QJ17fbNaFqtFVA@mail.gmail.com> <CAExDi1RYam46QLnd+i4zCF-CkfEoTXaWHwY6t=VjqFAsTYV9Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34811 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdIGEde (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 00:33:34 -0400
Received: by mail-yw0-f170.google.com with SMTP id r85so12149481ywg.1
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 21:33:34 -0700 (PDT)
In-Reply-To: <CAExDi1RYam46QLnd+i4zCF-CkfEoTXaWHwY6t=VjqFAsTYV9Eg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Sep 7, 2017 at 12:24 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Sep 7, 2017 at 6:02 AM, Christopher Li <sparse@chrisli.org> wrote:
>> On Wed, Sep 6, 2017 at 11:46 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>
>>>> For reducible graph that algorithm converge in constant iteration.

My statement is regarding *reducible* graph.

>>>
>>> Where the 'constant' is a function of the loop complexity (maximum
>>> nesting level) ...
>>
>> I think we are talking different things.
>
> Since you're talking performance and complexity, I suggest that you read
> carefully the section "Complexity Analysis" of the article and look where
> it's written 'd(G)' and 'loop connectedness'.

I assume you are talking page 7.  The 'd(G)'  and the "loop contentedness"
is actually referring to the *irreducible" graph. The Figure 4 is classic
*irreducible* graph. That is why I feel we are talking about different things.

Chris
