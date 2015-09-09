From: Thomas Graf <tgraf@suug.ch>
Subject: Re: rhashtable sparse annotations?
Date: Wed, 9 Sep 2015 23:13:51 +0200
Message-ID: <20150909211351.GD23451@pox.localdomain>
References: <CAHc6FU5U81nz+1eZeg13A4CX-+v06mOyMwY0mXQYrbRKNV=Bmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33067 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911AbbIIVNy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Sep 2015 17:13:54 -0400
Received: by wiclk2 with SMTP id lk2so6017460wic.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Sep 2015 14:13:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHc6FU5U81nz+1eZeg13A4CX-+v06mOyMwY0mXQYrbRKNV=Bmw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Nick Piggin <npiggin@kernel.dk>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On 09/09/15 at 04:14pm, Andreas Gruenbacher wrote:
> Hi,
> 
> I'm seeing the following sparse errors which are seemingly related to
> the hlist_bl_for_each_entry_rcu() macro:
> 
> $ make C=1 fs/dcache.o
> [...]
> include/linux/rculist_bl.h:23:33: error: incompatible types in
> comparison expression (different address spaces)
> fs/dcache.c:2183:9: error: incompatible types in comparison expression
> (different address spaces)
> include/linux/rculist_bl.h:23:33: error: incompatible types in
> comparison expression (different address spaces)
> fs/dcache.c:2303:9: error: incompatible types in comparison expression
> (different address spaces)
> 
> I'm hitting the same kinds of errors in the gfs2 rhashtable code as
> well, but it doesn't seem to happen in the network code. Does this
> need fixing in rhashtable?

What's the rhashtable related sparse error for gfs2?
