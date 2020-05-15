From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: complain about re-declared functions with different modifiers
Date: Fri, 15 May 2020 18:03:08 +0100
Message-ID: <e938cf36-8fe2-ab97-4179-e7927473d4fd@knosof.co.uk>
References: <20200514140451.GD2078@kadam>
 <CAHk-=wih1XbdV_MQ2OkcYPx2xZkvuhWKcLaZ=_wd8+5r3yLJQA@mail.gmail.com>
 <20200514205604.f4uxvv7lf4wrg4un@ltop.local>
 <CAHk-=wh_1ycEjZGN+qFBP8==XPF-+wsiyJ0=-J5JSMDMxmo32g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from know-smtprelay-omc-3.server.virginmedia.net ([80.0.253.67]:55393
        "EHLO know-smtprelay-omc-3.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEORIp (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 May 2020 13:08:45 -0400
In-Reply-To: <CAHk-=wh_1ycEjZGN+qFBP8==XPF-+wsiyJ0=-J5JSMDMxmo32g@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Linus,

> So I think sparse is in the wrong here, and we should consider both
> external and static symbols to be in the same scope and conflict with
> each other unless their declarations match.

Yes.

The C standard only has one one file scope (i.e., the is no
file scope+extra_stuff):
http://c0x.coding-guidelines.com/6.2.1.html

Difference between extern/static revolve around the concept of linkage:
http://c0x.coding-guidelines.com/6.2.2.html

-- 
Derek M. Jones           Evidence-based software engineering
tel: +44 (0)1252 520667  blog:shape-of-code.coding-guidelines.com
