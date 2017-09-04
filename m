From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Simple SSA status
Date: Mon, 4 Sep 2017 22:24:27 +0100
Message-ID: <CACXZuxdOWqquEqkuyp4XyNcgRukdGKYjZHY2MFBVTs9ntofL0A@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CACXZuxd7_8EktgM6JWNA83Bf_qm5yv8sc2OJ=3LT97jthKfAdQ@mail.gmail.com>
 <20170904205542.tb265qvphwjgr6om@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33967 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753962AbdIDVY2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 4 Sep 2017 17:24:28 -0400
Received: by mail-vk0-f54.google.com with SMTP id o22so3467573vke.1
        for <linux-sparse@vger.kernel.org>; Mon, 04 Sep 2017 14:24:28 -0700 (PDT)
In-Reply-To: <20170904205542.tb265qvphwjgr6om@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Luc,

On 4 September 2017 at 21:55, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Sep 04, 2017 at 09:37:17PM +0100, Dibyendu Majumdar wrote:
>> On 4 September 2017 at 21:07, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>
>> > About the phi-sources, I agree strongly with this. To me these
>> > phi-sources are just a nuisance. Once things will be in better
>> > shape, I'll see what can be done to get rid of them (quite a bit
>> > of the logic depends on them for the moment, though).
>> >
>>
>> As you know the backend relies upon the phisrc instruction and treats
>> it like a 'store' while treating the phi instructions as 'loads'.
>> Selfishly I would like this to remain as it seems changing it is not
>> necessary, but nice to have?
>
> Well, I'm not very sure about how you use these phisrc but from what
> I've understood, in sparse-llvm it's done like this because LLVM's phi
> can't be used *because* of the problems described here above.
> If I remove these phisources, I would of course adapt sparse-llvm
> to do the right thing.
>

Well I have alternative backend that does not have phi instructions.
Which also makes me think now that maybe it is better to keep the
introduction of phi instructions as a separate phase rather than doing
this at the time of linearization.

Regards
Dibyendu
