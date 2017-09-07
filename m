From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 05:46:47 +0200
Message-ID: <CAExDi1Qmv5iyZX2GQHa5jb7qTw+F8a3VmBXwBh+7EvpRfkQYtQ@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local> <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local> <CANeU7QmuZ1rWr08ZzGvyHDqmTvfgL9Abjzep2qWS3xQq7DL2XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33853 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbdIGDqt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 23:46:49 -0400
Received: by mail-lf0-f53.google.com with SMTP id l196so21736390lfl.1
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 20:46:49 -0700 (PDT)
In-Reply-To: <CANeU7QmuZ1rWr08ZzGvyHDqmTvfgL9Abjzep2qWS3xQq7DL2XA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Sep 7, 2017 at 4:20 AM, Christopher Li <sparse@chrisli.org> wrote:
>
> I am referring to the "A Simple, Fast Dominance Algorithm"
> ...
> For reducible graph that algorithm converge in constant iteration.

Where the 'constant' is a function of the loop complexity (maximum
nesting level) ...

-- Luc Van Oostenryck
