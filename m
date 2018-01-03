From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/2] give a type to builtin functions
Date: Wed, 3 Jan 2018 17:41:01 +0100
Message-ID: <20180103164057.qmhyx6eb47c26mm2@ltop.local>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
 <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
 <20180102151116.22060-2-luc.vanoostenryck@gmail.com>
 <20180103155743.240cb67f567d3fb4ae970ef7@redchan.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:43273 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeACQlE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 Jan 2018 11:41:04 -0500
Received: by mail-wm0-f51.google.com with SMTP id n138so3673653wmg.2
        for <linux-sparse@vger.kernel.org>; Wed, 03 Jan 2018 08:41:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180103155743.240cb67f567d3fb4ae970ef7@redchan.it>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: foobar <foobar@redchan.it>
Cc: linux-sparse@vger.kernel.org

On Wed, Jan 03, 2018 at 03:57:43PM +0000, foobar wrote:
> On Tue,  2 Jan 2018 16:11:15 +0100
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:
> 
> > When creating builtin functions via init-builtins(), it shouldn't
> > really be needed to give them a type because their purpose is only
> > as a placeholder for the symbol->op->{evaluate,expand,..}. Also,
> > they should be part of the builtin_scope and never be visible.
> 
> yeah, it seems odd (and annoying at the same time) that ctags emits internal symbols __builtin_bswap16 and similar stuff, unlike exuberant ctags.

There is several ways to change this but I need to think a bit
about it.

There is also that sparse's ctags work on the preprocessed source
while, I think, other ctags work purely on the lexical level,
thus on non-preprocessed sources.

Ciao and hanks for the bug repport
-- Luc
