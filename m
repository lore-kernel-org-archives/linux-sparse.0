From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Simple SSA status
Date: Mon, 4 Sep 2017 21:37:17 +0100
Message-ID: <CACXZuxd7_8EktgM6JWNA83Bf_qm5yv8sc2OJ=3LT97jthKfAdQ@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34468 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753962AbdIDUhS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 4 Sep 2017 16:37:18 -0400
Received: by mail-vk0-f42.google.com with SMTP id o22so3283371vke.1
        for <linux-sparse@vger.kernel.org>; Mon, 04 Sep 2017 13:37:18 -0700 (PDT)
In-Reply-To: <20170904200720.cxxfecd7rugyfskx@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Luc,

On 4 September 2017 at 21:07, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

> About the phi-sources, I agree strongly with this. To me these
> phi-sources are just a nuisance. Once things will be in better
> shape, I'll see what can be done to get rid of them (quite a bit
> of the logic depends on them for the moment, though).
>

As you know the backend relies upon the phisrc instruction and treats
it like a 'store' while treating the phi instructions as 'loads'.
Selfishly I would like this to remain as it seems changing it is not
necessary, but nice to have?

Regards
Dibyendu
